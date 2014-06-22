# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "implicit_connection_forbidder/version"

Gem::Specification.new do |spec|
  spec.name          = "implicit_connection_forbidder"
  spec.version       = ImplicitConnectionForbidder::VERSION
  spec.authors       = ["kml"]
  spec.email         = ["kamil.lemanski@gmail.com"]
  spec.summary       = %q{Implicit ActiveRecord connection forbidder.}
  spec.homepage      = "https://github.com/kml/implicit_connection_forbidder"
  spec.license       = "MIT"

  spec.files = Dir["lib/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  spec.test_files = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails", "~> 4.1.0"
  spec.add_development_dependency "sqlite3"
end

