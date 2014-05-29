module Rambulance
  class Railtie < Rails::Railtie
    initializer "action_controller" do |app|
      require "rambulance/exceptions_app"
    end

    initializer "activesupport.dependencies" do |app|
      begin
        ActiveSupport::Dependencies.load_missing_constant(Object, :ExceptionsApp)
        app.config.exceptions_app = ->(env){ ::ExceptionsApp.call(env) }
      rescue NameError
        app.config.exceptions_app = ::Rambulance::ExceptionsApp
      end
    end
  end
end
