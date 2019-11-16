# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "validate_me/version"

Gem::Specification.new do |spec|
  spec.name          = "validate_me"
  spec.version       = ValidateMe::VERSION
  spec.authors       = ["lollar"]
  spec.email         = ["mike@lollar.codes"]

  spec.summary       = "Built-in validations for ActiveRecord models"
  spec.description   = "Automatically adds validations to ActiveRecord models that match your database constraints"
  spec.homepage      = "https://github.com/lollar/validate_me"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0.0"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "sqlite3", "~> 1.4"
end
