appraise "rails_32" do
  gem "activesupport", "~> 3.2.0"
  gem "actionpack", "~> 3.2.0"
  gem "railties", "~> 3.2.0"
end

appraise "rails_40" do
  gem "activesupport", "~> 4.0.0"
  gem "actionpack", "~> 4.0.0"
  gem "railties", "~> 4.0.0"
  gem "test-unit" if RUBY_VERSION >= "2.2.0"
end

appraise "rails_41" do
  gem "activesupport", "~> 4.1.0"
  gem "actionpack", "~> 4.1.0"
  gem "railties", "~> 4.1.0"
end

appraise "rails_42" do
  gem "activesupport", "~> 4.2.0"
  gem "actionpack", "~> 4.2.0"
  gem "railties", "~> 4.2.0"

  gem 'minitest', '~> 5.3.4'
end

appraise "rails_edge" do
  git 'git://github.com/rails/rails.git' do
    gem "activesupport", require: 'active_support'
    gem "actionpack", require: 'action_pack'
    gem "railties"
  end

  gem 'minitest', '~> 5.3.4'
end
