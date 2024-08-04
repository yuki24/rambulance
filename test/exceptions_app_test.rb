require 'test_helper'

class ExeptionsAppTest < ActionDispatch::IntegrationTest
  test 'returns 404 for unknown format for pages that do not exist' do
    get '/does_not_exist', headers: { 'Accept' => '*/*'  }

    assert_equal 404, response.status
  end

  test 'returns 302 for unprocessable_entity' do
    get '/rambulance/unprocessable_entity', headers: { 'Accept' => '*/*'  }

    assert_redirected_to '/rambulance/unprocessable_content'
  end
end
