module Rambulance
  class Railtie < Rails::Railtie
    initializer 'rambulance', after: :prepend_helpers_path do |app|
      ActiveSupport.on_load(:action_controller) do
        require "rambulance/exceptions_app"
      end

      app.config.exceptions_app = ->(env) {
        begin
          ActiveSupport::Dependencies.load_missing_constant(Object, :ExceptionsApp)
          ::ExceptionsApp.call(env)
        rescue NameError
          require "rambulance/exceptions_app" if !defined?(::Rambulance::ExceptionsApp)
          ::Rambulance::ExceptionsApp.call(env)
        end
      }

      ActiveSupport.on_load(:after_initialize) do
        Rails.application.routes.append do
          mount app.config.exceptions_app, at: '/rambulance'
        end if Rails.env.development?
      end
    end
  end
end
