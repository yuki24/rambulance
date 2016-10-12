require 'test_helper'

class ErrorJsonTest < ActionDispatch::IntegrationTest
  test 'returns the 422 json for ActionController:InvalidAuthenticityToken but without its template' do
    get '/users/new'

    assert_equal 422, response.status
    assert_equal "Something went wrong", json_response['message']
  end

  test 'returns the 500 json for RuntimeError' do
    get '/users/1.json'

    assert_equal 500, response.status
    assert_equal "Something went wrong", json_response['message']
  end

  test 'returns the 404 json for CustomException' do
    get '/users.json'

    assert_equal 404, response.status
    assert_equal "Page not found", json_response['message']
  end

  test 'returns the 404 json for ActinoController::RoutingError' do
    get '/doesnt_exist.json'

    assert_equal 404, response.status
    assert_equal "Page not found", json_response['message']
  end

  private

  def without_layouts
    `mv test/fake_app/app/views/layouts/application.html.erb .`
    `mv test/fake_app/app/views/layouts/error.html.erb .`

    yield
  ensure
    `mv application.html.erb test/fake_app/app/views/layouts/`
    `mv error.html.erb test/fake_app/app/views/layouts/`
  end

  def get(path)
    without_layouts do
      if Rails::VERSION::STRING >= '5.1.0'
        super path, headers: { "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json" }
      else
        super path, nil, "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json"
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end if !ENV["CUSTOM_EXCEPTIONS_APP"]
