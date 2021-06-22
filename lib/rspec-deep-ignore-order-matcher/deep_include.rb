RSpec::Matchers.define :deep_include do |expected|
  match { |actual| deep_include? actual, expected }

  def deep_include?(actual, expected, path = [])
    return true if actual == expected
    @failing_path = path
    @failing_expected = expected
    @failing_actual = actual

    if actual.is_a? Array
      return false unless expected.is_a? Array
      expected.each_with_index do |expected_item, index|
        match_found = actual.any? do |actual_item|
          deep_include? actual_item, expected_item, path + [index]
        end
        unless match_found
          @failing_array = actual
          @failing_array_path = path + [index]
          @failing_expected_array_item = expected_item
          return false
        end
      end
    elsif actual.is_a? Hash
      return false unless expected.is_a? Hash
      expected.all? do |key, expected_value|
        return false unless actual.has_key? key
        deep_include? actual[key], expected_value, path + [key]
      end
    else
      false
    end
  end

  failure_message do |actual|
    if @failing_array_path
      path = @failing_array_path.map{ |p| "[#{p.inspect}]" }.join
      path = "root" if path.blank?
      message = "Actual array did not include value at #{path}: \n" +
        "  expected #{@failing_expected_array_item.inspect}\n" +
        "  but matching value not found in array: #{@failing_array}\n"
    else
      path = @failing_path.map{ |p| "[#{p.inspect}]" }.join
      path = "root" if path.blank?
      message = "Actual hash did not include expected value at #{path}: \n" +
        "  expected #{@failing_expected.inspect}\n" +
        "  got #{@failing_actual.inspect}\n"
    end

    message
  end
end