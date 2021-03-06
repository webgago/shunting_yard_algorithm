# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shunting_yard_algorithm/version'

Gem::Specification.new do |spec|
  spec.name          = "shunting_yard_algorithm"
  spec.version       = ShuntingYardAlgorithm::VERSION
  spec.authors       = ["Anton Sozontov"]
  spec.email         = ["a.sozontov@gmail.com"]
  spec.description   = %q{Shunting yard algorithm implementation on ruby}
  spec.summary       = %q{shunting yard algorithm implementation on ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
end
