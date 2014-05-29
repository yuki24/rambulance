module Rambulance
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      class_option :template_engine, type: :string, aliases: '-e', desc: 'Template engine for the views. Available options are "erb" and "haml".'

      def self.banner #:nodoc:
        <<-BANNER.chomp
rails g rambulance:install

    Copies all error partial templates and an initializer to your application.
BANNER
      end

      desc ''
      def copy_templates #:nodoc:
        filename_pattern = File.join(self.class.source_root, "views", "*.html.#{template_engine}")
        Dir.glob(filename_pattern).map {|f| File.basename f }.each do |f|
          copy_file "views/#{f}", "app/views/errors/#{f}"
        end
      end

      def copy_layout #:nodoc:
        copy_file "../../../../app/views/layouts/application.html.#{template_engine}", "app/views/layouts/error.html.#{template_engine}"
      end

      def copy_initializer #:nodoc:
        copy_file "rambulance.rb", "config/initializers/rambulance.rb"
      end

      private

      def template_engine
        options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      end
    end
  end
end
