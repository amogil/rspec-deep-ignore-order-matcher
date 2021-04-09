# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec-deep-ignore-order-matcher/version'

Gem::Specification.new do |gem|
  gem.name = 'rspec-deep-ignore-order-matcher'
  gem.version = Deep::Ignore::Order::Matcher::VERSION
  gem.authors = ['Alexey Mogilnikov']
  gem.email = ['alexey@mogilnikov.name']
  gem.description = 'This gem adds a custom matcher to RSpec to recursively compare nested Ruby data-structures consisting of `Hash` and `Array` elements. An order of elements in an array is ignored.'
  gem.summary = 'A custom matcher to RSpec to recursively compare nested Ruby data-structures consisting of `Hash` and `Array` elements.'
  gem.homepage = 'https://github.com/amogil/rspec-deep-ignore-order-matcher'
  gem.license = 'MIT'

  gem.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 2.7'
  
  gem.add_dependency 'rspec', '~> 3.10'  
  gem.add_development_dependency 'bundler', '~> 2.2'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rubocop', '~> 1.12'
end
