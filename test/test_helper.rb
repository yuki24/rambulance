$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rails'
require 'minitest/autorun'
require 'minitest/pride'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'bundler/setup'
Bundler.require

require 'fake_app/rails_app'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
