require 'test_helper'

class ErrorPageTest < ActionDispatch::IntegrationTest
  test 'displays the 500 page for RuntimeError' do
    visit '/users/1'

    assert_equal 500, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Something went wrong."
  end

  test 'displays the 404 page for CustomException' do
    visit '/users'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
  end

  test 'displays the 406 page for unknown format' do
    visit '/projects'

    assert_equal 200, page.status_code # Just to make sure normal html request succeeds

    visit '/projects.txt'

    assert_equal 406, page.status_code
  end

  test 'displays the 404 page for ActionController::RoutingError' do
    visit '/doesnt_exist'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
  end

  test 'displays the 400 page when malformed parameters' do
    page.driver.post '/users?x[y]=1&x[y][][w]=2'

    assert_equal 400, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Bad request."
  end

  test 'displays the 404 page for request to non-existing page with malformed parameters' do
    page.driver.post '/doesnt_exist?x[y]=1&x[y][][w]=2'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
  end

  if Rails.version < '4.2.0'
    # Versions eariler than 4.2 use `Rack::MethodOverride` that calls the 
    # request#POST method. It is configured to be called before the request
    # reaches Rails' ShowException, and it's impossible to capture from it.
    #
    # Since there is no good solution for us to fix it, I will consider it
    # to be a "won't fix" edge case and leave a test case here.
    test 'raises ArgumentError when posting malformed body' do
      assert_raises ArgumentError do
        page.driver.post '/users', 'email=abcd%%72900'
      end
    end
  elsif Rails.version.start_with?('4.2')
    test 'displays the 201 page' do
      page.driver.post '/users', 'email=abcd%%72900'

      assert_equal 201, page.status_code
      assert_includes page.body, "created."
    end
  else
    test 'displays the 400 page for POST request with malformed body' do
      page.driver.post '/users', 'email=abcd%%72900'

      assert_equal 400, page.status_code
      assert_includes page.body, "Error page"
      assert_includes page.body, "Bad request."
    end

    test 'displays the 400 page for PUT request with malformed body' do
      page.driver.put '/users/1', 'email=abcd%%72900'

      assert_equal 400, page.status_code
      assert_includes page.body, "Error page"
      assert_includes page.body, "Bad request."
    end

    test 'displays the 404 page for request to non-existing page with malformed body' do
      page.driver.post '/doesnt_exist', 'email=abcd%%72900'

      assert_equal 404, page.status_code
      assert_includes page.body, "Error page"
      assert_includes page.body, "Page not found."
    end
  end

  test 'displays the 403 page for ForbiddenException' do
    visit '/users/1/edit'

    assert_equal 403, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Forbidden."
  end

  test 'uses the custom layou twith a custom layout name' do
    @org, Rambulance.layout_name = Rambulance.layout_name, "application"

    begin
      visit '/doesnt_exist'
      assert_includes page.body, "Application page"
    ensure
      Rambulance.layout_name = @org
    end
  end

  test 'uses the 500 page and returns 422 when the template is missing' do
    visit '/users/new'

    assert_equal 422, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Something went wrong."
  end
end if !ENV["CUSTOM_EXCEPTIONS_APP"]

class ErrorPageWithCustomExceptionsAppTest < ActionDispatch::IntegrationTest
  test 'displays 500 page for RuntimeError' do
    visit '/users/1'

    assert_equal 500, page.status_code
    assert_includes page.body, "Custom error page"
  end

  test 'displays 404 page for ActinoController::RoutingError' do
    visit '/doesnt_exist'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
  end
end if ENV["CUSTOM_EXCEPTIONS_APP"]
