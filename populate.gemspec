# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'populate/version'

Gem::Specification.new do |spec|
  spec.name          = "populate"
  spec.version       = Populate::VERSION
  spec.authors       = ["Sébastien Gruchet"]
  spec.email         = ["gruchet@gmail.com"]
  spec.description   = %q{Perform mass sql insert}
  spec.summary       = %q{Perform mass sql insert}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-mocks"

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"

end
