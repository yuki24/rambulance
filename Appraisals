appraise "rails_32" do
  gem "activesupport", "~> 3.2.0"
  gem "actionpack", "~> 3.2.0"
  gem "railties", "~> 3.2.0"
  gem "test-unit" if RUBY_VERSION >= "2.2.0"
  gem 'nokogiri', '1.6.8.1' if RUBY_VERSION == "2.0.0"
end

appraise "rails_40" do
  gem "activesupport", "~> 4.0.0"
  gem "actionpack", "~> 4.0.0"
  gem "railties", "~> 4.0.0"
  gem "test-unit" if RUBY_VERSION >= "2.2.0"
  gem 'nokogiri', '1.6.8.1' if RUBY_VERSION == "2.0.0"
end

appraise "rails_41" do
  gem "activesupport", "~> 4.1.0"
  gem "actionpack", "~> 4.1.0"
  gem "railties", "~> 4.1.0"
  gem 'nokogiri', '1.6.8.1' if RUBY_VERSION == "2.0.0"
end

appraise "rails_42" do
  gem "activesupport", "~> 4.2.0"
  gem "actionpack", "~> 4.2.0"
  gem "railties", "~> 4.2.0"
  gem 'minitest', '~> 5.3.4'
  gem 'nokogiri', '1.6.8.1' if RUBY_VERSION == "2.0.0"
end

appraise "rails_50" do
  gem "activesupport", "~> 5.0.0"
  gem "actionpack", "~> 5.0.0"
  gem "railties", "~> 5.0.0"
  gem 'minitest', '~> 5.3.4'
end

appraise "rails_51" do
  gem "activesupport", "~> 5.1.0"
  gem "actionpack", "~> 5.1.0"
  gem "railties", "~> 5.1.0"
end

appraise "rails_52" do
  gem "activesupport", "~> 5.2.0.rc1"
  gem "actionpack", "~> 5.2.0.rc1"
  gem "railties", "~> 5.2.0.rc1"
end

appraise "rails_edge" do
  git 'git://github.com/rails/rails.git' do
    gem "activesupport", require: 'active_support'
    gem "actionpack", require: 'action_pack'
    gem "railties"
  end

  gem 'minitest', '~> 5.3.4'
end
