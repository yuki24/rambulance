module Rambulance
  class Railtie < Rails::Railtie
    initializer 'rambulance' do |app|
      require "rambulance/exceptions_app"

      app.config.exceptions_app =
        begin
          ActiveSupport::Dependencies.load_missing_constant(Object, :ExceptionsApp)
          ->(env){ ::ExceptionsApp.call(env) }
        rescue NameError
          ::Rambulance::ExceptionsApp
        end

      ActiveSupport.on_load(:after_initialize) do
        Rails.application.routes.append do
          mount app.config.exceptions_app, at: '/rambulance'
        end if Rails.env.development?
      end
    end
  end
end
