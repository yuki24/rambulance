require "rambulance/version"
require "rambulance/railtie"

module Rambulance

  # List of custom pairs of exception/corresponding http status.
  mattr_reader :rescue_responses
  @@rescue_responses = {}

  # The name of the layout file for the error pages.
  mattr_accessor :layout_name
  @@layout_name = "application"

  # The directry name to organize error page templates.
  mattr_accessor :view_path
  @@view_path = "errors"

  def self.rescue_responses=(rescue_responses)
    @@rescue_responses = rescue_responses
    ActionDispatch::ExceptionWrapper.rescue_responses.merge!(rescue_responses)
  end

  def self.setup
    yield self
  end
end
