require 'action_controller/railtie'
require 'action_view/railtie'
require 'jbuilder'

# config
app = Class.new(Rails::Application)
app.config.secret_token = '964ab2f0fbbb68bc36f3cc487ca296bb8555fac50627924024c245a1599e5265'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false

# Rais.root
app.config.root = File.dirname(__FILE__)
app.config.autoload_paths += ["#{app.config.root}/lib"] if ENV["CUSTOM_EXCEPTIONS_APP"]
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :users
end

# custom exception class
class CustomException < StandardError; end

Rambulance.setup do |config|
  config.layout_name = "error"
  config.rescue_responses = {
    'TypeError'       => :bad_request,
    'CustomException' => :not_found
  }
end

# controllers
class ApplicationController < ActionController::Base
  append_view_path "spec/fake_app/views"
  before_filter :bad_filter

  private

  def bad_filter
    raise "This is a bad filter."
  end
end
class UsersController < ApplicationController
  skip_filter :bad_filter, except: :show

  def index
    raise CustomException
  end

  def show; end

  def new
    raise ActionController::InvalidAuthenticityToken
  end

  def create; end
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
