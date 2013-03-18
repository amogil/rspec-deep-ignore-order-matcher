# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-deep-ignore-order-matcher/version'

Gem::Specification.new do |gem|
	gem.name = "rspec-deep-ignore-order-matcher"
	gem.version = Deep::Ignore::Order::Matcher::VERSION
	gem.authors = ["Alexey Mogilnikov"]
	gem.email = ["alexey@mogilnikov.name"]
	gem.description = %q{TODO: Write a gem description}
	gem.summary = %q{TODO: Write a gem summary}
	gem.homepage = ""

	gem.files = `git ls-files`.split($/)
	gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
	gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]

	s.add_development_dependency "rspec", "~> 2.6"
end
