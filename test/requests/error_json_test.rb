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

  test 'renders an error page on a POST request' do
    post '/projects.json'

    assert_equal 500, response.status
    assert_equal "Something went wrong", json_response['message']
  end

  test 'returns an appropriate status based on the rails version when the HTTP Accept header is malformed' do
    if Rails::VERSION::STRING >= '5.1.0'
      post '/users', headers: { "HTTP_ACCEPT" => "image/apng*/*" }
    else
      post '/users', nil, "HTTP_ACCEPT" => "image/apng*/*"
    end

    if Rails::VERSION::STRING >= '6.0.0'
      assert_equal 406, response.status
      assert_equal "The requested content type is not acceptable.\n", response.body
    elsif Rails::VERSION::STRING >= '5.2.0'
      assert_equal 422, response.status
    elsif Rails::VERSION::STRING >= '5.1.0'
      assert_equal 500, response.status
    elsif Rails::VERSION::STRING >= '4.2.0'
      assert_equal 201, response.status
    end
  end

  test 'returns an appropriate status based on the rails version when the HTTP Content-type header is malformed' do
    if Rails::VERSION::STRING >= '5.1.0'
      post '/users', headers: { "CONTENT_TYPE" => "charset=gbk" }
    else
      post '/users', nil, "CONTENT_TYPE" => "charset=gbk"
    end

    if Rails::VERSION::STRING >= '6.0.0'
      assert_equal 406, response.status
      assert_equal "The requested content type is not acceptable.\n", response.body
    elsif Rails::VERSION::STRING >= '5.2.0'
      assert_equal 422, response.status
    elsif Rails::VERSION::STRING >= '5.1.0'
      assert_equal 500, response.status
    elsif Rails::VERSION::STRING >= '4.2.0'
      assert_equal 201, response.status
    end
  end

  test 'returns an appropriate status when JSON data is malformed' do
    if Rails::VERSION::STRING >= '5.1.0'
      post '/unknown/path', params: 'x', headers: { "CONTENT_TYPE" => "application/json" }
    else
      post '/unknown/path', 'x', "CONTENT_TYPE" => "application/json"
    end

    assert_equal 404, response.status
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

  def get(path, params: {}, headers: {})
    without_layouts do
      if Rails::VERSION::STRING >= '5.1.0'
        super path, params: params, headers: { "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json" }.merge(headers)
      else
        super path, params, { "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json" }.merge(headers)
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end if !ENV["CUSTOM_EXCEPTIONS_APP"]
