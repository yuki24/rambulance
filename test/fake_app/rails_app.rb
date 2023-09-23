require 'jbuilder'
require 'rake'

# This task needs to be defined before the Rails application is loaded so Rambulance can override it.
Rake::Task.define_task('assets:precompile')

# config
class TestApp < Rails::Application
  config.secret_token = '964ab2f0fbbb68bc36f3cc487ca296bb8555fac50627924024c245a1599e5265'
  config.session_store :cookie_store, :key => '_myapp_session'
  config.active_support.cache_format_version = 7.1 if Rails::VERSION::STRING >= "7.1"
  config.active_support.deprecation = :log
  config.eager_load = false
  config.root = File.dirname(__FILE__)
  config.autoload_paths += ["#{config.root}/lib"] if ENV["CUSTOM_EXCEPTIONS_APP"]
  config.hosts = "www.example.com"
  config.rambulance.static_error_pages = !!ENV["STATIC_ERROR_PAGES"]

  if Rails::VERSION::STRING >= "5.2"
    config.action_controller.default_protect_from_forgery = true
  end
end
Rails.backtrace_cleaner.remove_silencers!
Rails.application.load_tasks if ENV["STATIC_ERROR_PAGES"]
Rails.application.initialize!

# routes
Rails.application.routes.draw do
  resources :users
  resources :projects, only: [:index, :create]
end

# custom exception class
class CustomException < StandardError; end
class ForbiddenException < StandardError; end

Rambulance.setup do |config|
  config.layout_name = "error"
  config.rescue_responses = {
    'TypeError'       => :bad_request,
    'CustomException' => :not_found,
    'ForbiddenException' => :forbidden
  }
end

# controllers
class ApplicationController < ActionController::Base
  append_view_path "spec/fake_app/views"
  if self.respond_to? :before_filter
    before_filter :bad_filter
  else
    before_action :bad_filter
  end

  private

  def bad_filter
    raise "This is a bad filter."
  end
end

class UsersController < ApplicationController
  if self.respond_to? :skip_before_action
    skip_before_action :bad_filter, except: :show
  else
    skip_filter :bad_filter, except: :show
  end

  def index
    raise CustomException
  end

  def show; end

  def new
    raise ActionController::InvalidAuthenticityToken
  end

  def create
    render text: 'created.', status: 201
  end

  def update
    render text: 'updated.', status: 201
  end

  def edit
    raise ForbiddenException
  end
end

class ProjectsController < ApplicationController
  if self.respond_to?(:skip_forgery_protection)
    skip_forgery_protection
  end

  if self.respond_to? :skip_before_action
    skip_before_action :bad_filter, except: :create
  else
    skip_filter :bad_filter, except: :create
  end

  def index; end
  def create; end
end
