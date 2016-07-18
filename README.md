# RSpec Deep Matcher

[![Gem Version](https://badge.fury.io/rb/rspec-deep-ignore-order-matcher.png)](http://badge.fury.io/rb/rspec-deep-ignore-order-matcher)
[![Code Climate](https://codeclimate.com/github/amogil/rspec-deep-ignore-order-matcher/badges/gpa.svg)](https://codeclimate.com/github/amogil/rspec-deep-ignore-order-matcher)
[![Build Status](https://travis-ci.org/amogil/rspec-deep-ignore-order-matcher.svg?branch=master)](https://travis-ci.org/amogil/rspec-deep-ignore-order-matcher)
[comment]: [![Dependency Status](https://gemnasium.com/badges/github.com/amogil/rspec-deep-ignore-order-matcher.svg)](https://gemnasium.com/github.com/amogil/rspec-deep-ignore-order-matcher)

This gem adds a custom matcher to RSpec to recursively compare nested Ruby data-structures consisting of Hash and Array elements.
An order of elements in an array is ignored.

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

## Example
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
