require "rambulance/version"
require "rambulance/railtie"

module Rambulance

  mattr_reader :rescue_responses
  @@rescue_responses = {}

  mattr_reader :layout_name
  @@layout_name = "error"

  mattr_accessor :view_path
  @@view_path = "errors"

  def self.rescue_responses=(exception_mapping)
    @@rescue_responses = exception_mapping
    ActionDispatch::ExceptionWrapper.rescue_responses.merge!(exception_mapping)
  end

  def self.layout_name=(layout_name)
    @@layout_name = layout_name
    ::Rambulance::ExceptionsApp.layout(layout_name)
  end

  def self.setup
    yield self
  end
end
