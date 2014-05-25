# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rambulance/version"

Gem::Specification.new do |spec|
  spec.name          = "rambulance"
  spec.version       = Rambulance::VERSION
  spec.authors       = ["Yuki Nishijima"]
  spec.email         = ["mail@yukinishijima.net"]
  spec.summary       = %q{Simple and safe way to dynamically generate error pages}
  spec.description   = %q{Rambulance provides a simple and safe way to dynamically generate error pages.}
  spec.homepage      = "http://github.com/yuki24/rambulance"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "actionpack"
  spec.add_dependency "railties"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "tzinfo"
  spec.add_development_dependency "jbuilder"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "appraisal"
end
