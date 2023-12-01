# frozen_string_literal: true
module Rambulance #:nodoc:
  module TestHelper
    # enables the exceptions app in the block.
    #
    # Rspec:
    #
    #   it "shows an error page" do
    #     with_exceptions_app do
    #       get '/'
    #     end
    #
    #     ...
    #   end
    #
    # Minitest:
    #
    #   test "it shows an error page" do
    #     with_exceptions_app do
    #       get '/'
    #     end
    #
    #     ...
    #   end
    #
    def with_exceptions_app(enabled: true)
      org_show_detailed_exceptions = Rails.application.env_config['action_dispatch.show_detailed_exceptions']
      org_show_exceptions          = Rails.application.env_config['action_dispatch.show_exceptions']

      Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = !enabled
      Rails.application.env_config['action_dispatch.show_exceptions']          = enabled ? :all : org_show_exceptions

      yield
    ensure
      Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = org_show_detailed_exceptions
      Rails.application.env_config['action_dispatch.show_exceptions']          = org_show_exceptions
    end
  end
end
