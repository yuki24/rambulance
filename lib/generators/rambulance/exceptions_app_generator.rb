module Rambulance
  module Generators
    class ExceptionsAppGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def self.banner #:nodoc:
        <<-BANNER.chomp
rails g rambulance:exceptions_app

    Creates a custom exceptions app.
BANNER
      end

      desc ''
      def copy_exceptions_app #:nodoc:
        copy_file "exceptions_app.rb", "app/handlers/exceptions_app.rb"
      end
    end
  end
end
