module Rambulance
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      class_option :template_engine,
        type: :string,
        aliases: '-e',
        desc: 'Template engine for the views. Available options are "erb", "slim" and "haml".'

      class_option :error_layout,
        type: :string,
        aliases: '-l',
        desc: 'Copies app/views/layout/application.html.erb to the specified layout name'

      def self.banner #:nodoc:
        <<-BANNER.chomp
rails g rambulance:install

    Copies all error partial templates and an initializer to your application.
BANNER
      end

      desc ''
      def copy_templates #:nodoc:
        say "generating templates:"
        filename_pattern = File.join(self.class.source_root, "views", "*#{file_extname}")
        Dir.glob(filename_pattern).map {|f| File.basename f }.each do |f|
          copy_file "views/#{f}", "app/views/errors/#{f}"
        end
      end

      def copy_layout #:nodoc:
        return if layout_name == "application"

        say "\n" "copying app/views/layouts/application.html.#{template_engine} to app/views/layouts/#{layout_name}.html.#{template_engine}:"
        copy_file Rails.root.join("app/views/layouts/application.html.#{template_engine}"), "app/views/layouts/#{layout_name}.html.#{template_engine}"
      end

      def copy_initializer #:nodoc:
        say "\n" "generating initializer:"
        template "rambulance.rb", "config/initializers/rambulance.rb"
      end

      private

      def template_engine
        options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      end

      def layout_name
        options[:error_layout].try(:to_s).try(:downcase) || "application"
      end

      def longest_error_name_size
        ActionDispatch::ExceptionWrapper.rescue_responses.keys.sort_by(&:size).last.size
      end

      def file_extname
        case template_engine
        when "jbuilder"
          ".json.jbuilder"
        else
          ".html.#{template_engine}"
        end
      end
    end
  end
end
