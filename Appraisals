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
  gem "activesupport", "~> 5.2.0"
  gem "actionpack", "~> 5.2.0"
  gem "railties", "~> 5.2.0"
end

appraise "rails_60" do
  gem "activesupport", "~> 6.0.0"
  gem "actionpack", "~> 6.0.0"
  gem "railties", "~> 6.0.0"
end

appraise "rails_61" do
  gem "activesupport", "~> 6.1.0"
  gem "actionpack", "~> 6.1.0"
  gem "railties", "~> 6.1.0"
end

appraise "rails_70" do
  gem "activesupport", "~> 7.0.0"
  gem "actionpack", "~> 7.0.0"
  gem "railties", "~> 7.0.0"
end

appraise "rails_edge" do
  git 'https://github.com/rails/rails.git' do
    gem "activesupport", require: 'active_support'
    gem "actionpack", require: 'action_pack'
    gem "railties"
  end

  gem 'minitest', '~> 5.3.4'
end
