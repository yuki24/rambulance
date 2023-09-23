require 'test_helper'

class ExeptionsAppTest < ActionDispatch::IntegrationTest
  test 'returns 404 for unknown format for pages that do not exist' do
    get '/does_not_exist', headers: { 'Accept' => '*/*' }

    assert_equal 404, response.status
  end

  if Rails.version >= '5.0.0'
    test '#precompile! generates static HTML files for each error status' do
      Dir[Rails.public_path.join("*.html")].each do |file|
        File.delete(file)
      end
  
      Rambulance::ExceptionsApp.precompile!
  
      assert File.exist?(Rails.public_path.join("400.html"))
      assert File.exist?(Rails.public_path.join("403.html"))
      assert File.exist?(Rails.public_path.join("404.html"))
      assert File.exist?(Rails.public_path.join("406.html"))
      assert File.exist?(Rails.public_path.join("500.html"))
      assert_not File.exist?(Rails.public_path.join("401.html"))
    end
  end
end
