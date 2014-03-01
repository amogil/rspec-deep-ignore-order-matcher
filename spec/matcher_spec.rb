require 'spec'
require 'rspec-deep-ignore-order-matcher'

describe Deep::Ignore::Order::Matcher do

	it 'should match heterogeneous values' do
		['an_string', 1, 13.5, nil, [1, 2, 3], { :a => 1, :b => 2 }].each_slice(2) do |value1, value2|
			value1.should be_deep_equal value1
			value2.should be_deep_equal value2
			value1.should_not be_deep_equal value2
			value2.should_not be_deep_equal value1
		end
	end

	it 'should ignore order in plain arrays' do
		actual = Array.new(5) { Kernel.rand(1000) }
		expected = actual.sort
		actual.should be_deep_equal expected
	end

	it 'should match deep structs' do
		actual = [{ :a => 1, :b => 'str', :c => [1, 2, 3] }, [{ :a => [2, { :a => 4 }] }, { :b => 2 }, { :c => 3 }]]
		expected = [{ :a => 1, :b => 'str', :c => [3, 1, 2] }, [{ :b => 2 }, { :a => [{ :a => 4 }, 2] }, { :c => 3 }]]
		actual.should be_deep_equal expected
		actual[0][:c].push(4)
		actual.should_not be_deep_equal expected
	end

	it 'should not match partials' do
		[1, 2, 3].should_not be_deep_equal [1, 2]
		[1, 2].should_not be_deep_equal [1, 2, 3]
		{ :a => 1, :b => 2 }.should_not be_deep_equal({ :a => 1 })
		{ :a => 1 }.should_not be_deep_equal({ :a => 1, :b => 2 })
	end

	it 'should ignore hash keys order' do
		{ :a => 1, :b => 2 }.should be_deep_equal({ :b => 2, :a => 1 })
  end
end
