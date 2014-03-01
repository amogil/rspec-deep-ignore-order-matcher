# RSpec-1 Deep Matcher

This gem adds a custom matcher to RSpec-1 / Ruby 1.8.x to recursively compare nested Ruby data structures consisting of Hash and Array elements.
Array element order is ignored. Symbols are converted to strings for comparison purposes.

For RSpec-2 and Ruby 1.9+ compatibility, please see the [original gem](https://rubygems.org/gems/rspec-deep-ignore-order-matcher)
 by Alexey Mogilnikov.

## Install
```
gem install rspec-deep-ignore-order-matcher
```
or add to your `Gemfile`
```
gem 'rspec-deep-ignore-order-matcher'
```
and run
```
bundle install
```

## Usage
```
require 'rspec-deep-ignore-order-matcher'

describe 'Products' do
	it "should ignore order of product's tags" do
		expected = [{ :product => { :title => 'Product 1', :tags => ['large', 'blue', 'heavy'] } }]
		actual = [{ :product => { :title => 'Product 1', :tags => ['blue', 'large', 'heavy'] } }]
		actual.should be_deep_equal expected
	end
end
```

This custom matcher is diffable:
```bundle exec spec spec/some_spec.rb --diff```

## Develop

[RSpec Custom Matchers](https://github.com/dchelimsky/rspec/wiki/Custom-Matchers)

## Acknowledgments

Thanks to
 
* David Chelimsky for [RSpec-1](http://old.rspec.info)
* Alexey Mogilnikov for the [original gem](https://rubygems.org/gems/rspec-deep-ignore-order-matcher)