require 'rspec'
require 'rspec_deep_ignore_order_matcher'

describe Deep::Ignore::Order::Matcher do
  it 'should matches usual values' do
    ['an_string', 1, 13.5, nil, [1, 2, 3], { a: 1, b: 2 }].each_slice(2) do |value1, value2|
      expect(value1).to be_deep_equal value1
      expect(value2).to be_deep_equal value2
      expect(value1).to_not be_deep_equal value2
      expect(value2).to_not be_deep_equal value1
    end
  end

  it 'should ignore order in plain arrays' do
    actual = Array.new(5) { Random.rand(1000) }
    expected = actual.sort
    expect(actual).to be_deep_equal expected
  end

  it 'should match deep structs' do
    actual = [{ a: 1, b: 'str', c: [1, 2, 3] }, [{ a: [2, { a: 4 }] }, { b: 2 }, { c: 3 }]]
    expected = [{ a: 1, b: 'str', c: [3, 1, 2] }, [{ b: 2 }, { a: [{ a: 4 }, 2] }, { c: 3 }]]
    expect(actual).to be_deep_equal expected
    actual[0][:c].push(4)
    expect(actual).to_not be_deep_equal expected
  end

  it 'should do not match partials' do
    expect([1, 2, 3]).to_not be_deep_equal [1, 2]
    expect([1, 2]).to_not be_deep_equal [1, 2, 3]
    expect(a: 1, b: 2).to_not be_deep_equal(a: 1)
    expect(a: 1).to_not be_deep_equal(a: 1, b: 2)
  end

  it 'should ignore hash keys order' do
    expect(a: 1, b: 2).to be_deep_equal(b: 2, a: 1)
  end
end
