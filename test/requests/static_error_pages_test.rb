require 'test_helper'

class StaticErrorPagesTest < ActionController::TestCase
  if ENV["STATIC_ERROR_PAGES"]
    test 'the exceptions app is set to PublicExceptions' do
      assert_nil Rails.application.config.exceptions_app
    end

    test 'the assets:precompile task is enhanced with rambulance:precompile' do
      assert_not_empty Rake::Task['assets:precompile'].actions
    end
  else
    test 'the exceptions app is set to PublicExceptions' do
      assert_not_nil Rails.application.config.exceptions_app
    end

    test 'the assets:precompile task is not enhanced with rambulance:precompile' do
      assert_empty Rake::Task['assets:precompile'].actions
    end
  end

  test 'the exceptions app is mounted on /rambulance' do
    route = Rails.application.routes.routes.find { |route| route.path.spec.to_s == '/rambulance' }

    assert_not_nil route
  end
end
