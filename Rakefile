require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new('test:default') do |task|
  task.libs << "test"

  task.test_files = Dir['test/**/*_test.rb']
  task.verbose = true
  task.warning = true
end

namespace :test do
  desc "Run Tests with a custom exceptions app"
  task :custom do
    sh "rake test:default CUSTOM_EXCEPTIONS_APP=1"
  end

  desc "Run tests for the static page mode"
  task :static_pages do
    sh "TEST=test/requests/static_error_pages_test.rb STATIC_ERROR_PAGES=1 rake test:default"
  end
end

task(:test).enhance %w(test:default test:custom test:static_pages)
task default: :test
