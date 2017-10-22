require 'jbuilder'

# config
class TestApp < Rails::Application
  config.secret_token = '964ab2f0fbbb68bc36f3cc487ca296bb8555fac50627924024c245a1599e5265'
  config.session_store :cookie_store, :key => '_myapp_session'
  config.active_support.deprecation = :log
  config.eager_load = false
  config.root = File.dirname(__FILE__)
  config.autoload_paths += ["#{config.root}/lib"] if ENV["CUSTOM_EXCEPTIONS_APP"]
end
Rails.backtrace_cleaner.remove_silencers!
Rails.application.initialize!

# routes
Rails.application.routes.draw do
  resources :users
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

  def create; end

  def edit
    raise ForbiddenException
  end
end
