# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-deep-ignore-order-matcher/version'

Gem::Specification.new do |gem|
  gem.name = "rspec-deep-ignore-order-matcher"
	gem.version = Deep::Ignore::Order::Matcher::VERSION
	gem.authors = ["Magne Land"]
	gem.email = ["rubygems@land.no"]
	gem.description = %q{This gem adds a custom matcher to RSpec-1 to recursively compare nested Ruby data structures consisting of `Hash` and `Array` elements.}
	gem.summary = %q{A custom matcher to RSpec-1 to recursively compare nested Ruby data structures consisting of `Hash` and `Array` elements.}
	gem.homepage = 'https://github.com/magneland/rspec-deep-ignore-order-matcher'

	gem.files = `git ls-files`.split($/)
	gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
	gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]

  gem.add_dependency 'rspec', '~> 1.3'
end
