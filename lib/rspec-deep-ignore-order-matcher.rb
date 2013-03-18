require 'rspec'
require 'rspec-deep-ignore-order-matcher/version'

RSpec::Matchers.define :be_deep_equal do |expected|
	match { |actual| m? actual, expected }

	failure_message_for_should do |actual|
		"expected that #{actual} would be deep equal with #{expected}"
	end

	failure_message_for_should_not do |actual|
		"expected that #{actual} would not be deep equal with #{expected}"
	end

	description do
		"be deep equal with #{expected}"
	end

	def m?(actual, expected)
		return arrays_matches?(actual, expected) if expected.is_a?(Array) && actual.is_a?(Array)
		return hashes_matches?(actual, expected) if expected.is_a?(Hash) && actual.is_a?(Hash)
		expected == actual
	end

	def arrays_matches?(actual, expected)
		exp = expected.clone
		actual.each do |a|
			index = exp.find_index { |e| m? a, e }
			return false if index.nil?
			exp.delete_at(index)
		end
		exp.length == 0
	end

	def hashes_matches?(actual, expected)
		return false unless actual.keys.sort == expected.keys.sort
		actual.each { |key, value| return false unless m? value, expected[key] }
		true
	end
end
