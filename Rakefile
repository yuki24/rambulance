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
    sh "CUSTOM_EXCEPTIONS_APP=1 rake test:default"
  end
end

task(:test).enhance %w(test:default test:custom)
task default: :test
