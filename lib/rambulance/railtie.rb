module Rambulance
  class Railtie < Rails::Railtie
    config.rambulance = ActiveSupport::OrderedOptions.new
    config.rambulance.static_error_pages = false

    initializer 'rambulance', after: :prepend_helpers_path do |app|
      ActiveSupport.on_load(:action_controller) do
        require "rambulance/exceptions_app"
      end

      exceptions_app = if app.config.respond_to?(:autoloader) && app.config.autoloader == :classic
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

      if !app.config.rambulance.static_error_pages
        app.config.exceptions_app = exceptions_app
      end

      ActiveSupport.on_load(:after_initialize) do
        if Rails.env.development?
          Rails.application.routes.append do
            mount exceptions_app, at: '/rambulance'
          end
        end
      end
    end

    rake_tasks do
      require 'rambulance/exceptions_app'

      if config.rambulance.static_error_pages && Rake::Task.task_defined?("assets:precompile")
        Rake::Task["assets:precompile"].enhance do
          Rake::Task["rambulance:precompile"].invoke
        end
      end
    end
  end
end
