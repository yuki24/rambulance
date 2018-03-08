require 'test_helper'

class TestHelperTest < ActionDispatch::IntegrationTest
  include Rambulance::TestHelper

  test '#with_exceptions_app can enable the exceptions app in test' do
    with_exceptions_app do
      get '/does_not_exist'
    end

    assert_equal 404, response.status
  end

  test '#with_exceptions_app can disable the exceptions app in test' do
    with_exceptions_app enabled: false do
      assert_raises ActionController::RoutingError do
        get '/does_not_exist'
      end
    end
  end
end

