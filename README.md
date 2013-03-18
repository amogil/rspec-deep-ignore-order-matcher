# RSpec Deep Matcher

This gem adds a custom matcher to RSpec to recursively compare nested Ruby data-structures consisting of Hash and Array elements.
An order of elements in an array is ignored.

## Install
```
sudo gem install rspec-deep-ignore-order-matcher
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
describe 'Products' do
	it "should ignore order of product's tags" do
		expected = [{ :product => { :title => 'Product 1', :tags => ['large', 'blue', 'heavy'] } }]
		actual = [{ :product => { :title => 'Product 1', :tags => ['blue', 'large', 'heavy'] } }]
		actual.should be_deep_equal expected
	end
end
```