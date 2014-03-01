require 'spec' # RSpec-1
require 'rspec-deep-ignore-order-matcher/version'

Spec::Matchers.define :be_deep_equal do |expected|
	match { |actual| m? actual, expected }

	failure_message_for_should do |actual|
		"expected that #{actual.pretty_print_inspect} would be deep equal with #{expected.pretty_print_inspect}"
	end

	failure_message_for_should_not do |actual|
		"expected that #{actual.pretty_print_inspect} would not be deep equal with #{expected.pretty_print_inspect}"
	end

	description do
		"be deep equal with #{expected.pretty_print_inspect}"
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
    # convert symbols to strings for sorting
		return false unless actual.keys.sort{ |a, b| a.to_s <=> b.to_s } == expected.keys.sort{ |a, b| a.to_s <=> b.to_s }
    actual.each { |key, value| return false unless m? value, expected[key] }
		true
  end

  diffable # usage: spec --diff
end
