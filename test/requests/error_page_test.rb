require 'test_helper'

class ErrorPageTest < ActionDispatch::IntegrationTest
  test 'displays the 500 page for RuntimeError' do
    expected_status_code = Rails::VERSION::MAJOR >= 5 ? 406 : 500

    visit '/users/1'

    assert_equal expected_status_code, page.status_code 
    assert_includes page.body, "Error page"
    assert_includes page.body, "Something went wrong."
  end

  test 'displays the 404 page for CustomException' do
    visit '/users'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
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
    expected_status_code = Rails::VERSION::MAJOR >= 5 ? 406 : 500

    visit '/users/1'

    assert_equal expected_status_code, page.status_code
    assert_includes page.body, "Custom error page"
  end

  test 'displays 404 page for ActinoController::RoutingError' do
    visit '/doesnt_exist'

    assert_equal 404, page.status_code
    assert_includes page.body, "Error page"
    assert_includes page.body, "Page not found."
  end
end if ENV["CUSTOM_EXCEPTIONS_APP"]
