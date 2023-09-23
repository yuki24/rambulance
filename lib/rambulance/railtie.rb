module Rambulance
  class Railtie < Rails::Railtie
    config.rambulance = ActiveSupport::OrderedOptions.new
    config.rambulance.static_error_pages = false

    initializer 'rambulance', after: :prepend_helpers_path do |app|
      ActiveSupport.on_load(:action_controller) do
        require "rambulance/exceptions_app"
      end

      app.config.exceptions_app =
        if app.config.respond_to?(:autoloader) && app.config.autoloader == :classic
          ->(env) {
            begin
              ActiveSupport::Dependencies.load_missing_constant(Object, :ExceptionsApp)
              ::ExceptionsApp.call(env)
            rescue NameError
              require "rambulance/exceptions_app" if !defined?(::Rambulance::ExceptionsApp)
              ::Rambulance::ExceptionsApp.call(env)
            end
          }
        else
          ->(env) {
            begin
              ::ExceptionsApp.call(env)
            rescue NameError
              require "rambulance/exceptions_app" if !defined?(::Rambulance::ExceptionsApp)
              ::Rambulance::ExceptionsApp.call(env)
            end
          }
        end

      ActiveSupport.on_load(:after_initialize) do
        Rails.application.routes.append do
          mount app.config.exceptions_app, at: '/rambulance'
        end if Rails.env.development?
      end
    end

    rake_tasks do
      require 'rambulance/exceptions_app'

      if config.rambulance.static_error_pages
        Rake::Task["assets:precompile"].enhance do
          Rake::Task["rambulance:precompile"].invoke
        end
      end
    end
  end
end
