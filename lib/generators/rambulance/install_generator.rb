module Rambulance
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      class_option :template_engine,
        type: :string,
        aliases: '-e',
        desc: 'Template engine for the views. Available options are "erb", "slim" and "haml".'

      def self.banner #:nodoc:
        <<-BANNER.chomp
rails g rambulance:install

    Copies all error partial templates and an initializer to your application.
BANNER
      end

      desc ''
      def copy_templates #:nodoc:
        say "generating templates:"
        filename_pattern = File.join(self.class.source_root, "views", "*.html.#{template_engine}")
        Dir.glob(filename_pattern).map {|f| File.basename f }.each do |f|
          copy_file "views/#{f}", "app/views/errors/#{f}"
        end

        if defined?(Jbuilder)
          filename_pattern = File.join(self.class.source_root, "views", "*.json.jbuilder")
          Dir.glob(filename_pattern).map {|f| File.basename f }.each do |f|
            copy_file "views/#{f}", "app/views/errors/#{f}"
          end
        end
      end

      def copy_layout #:nodoc:
        say "\ncopying app/views/layouts/application.html.#{template_engine} to app/views/layouts/error.html.#{template_engine}:"
        copy_file Rails.root.join("app/views/layouts/application.html.#{template_engine}"), "app/views/layouts/error.html.#{template_engine}"
      end

      def copy_initializer #:nodoc:
        say "\n" "generating initializer:"
        template "rambulance.rb", "config/initializers/rambulance.rb"
      end

      private

      def template_engine
        options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      end

      def longest_error_name_size
        ActionDispatch::ExceptionWrapper.rescue_responses.keys.sort_by(&:size).last.size
      end
    end
  end
end
