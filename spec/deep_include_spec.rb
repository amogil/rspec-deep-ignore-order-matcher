require 'rspec'
require 'rspec_deep_ignore_order_matcher'

describe "deep_include matcher" do
  let(:actual) { deep_clone(expected) }

  context "given complex hash expectation" do
    let(:expected) do
      {
        hash_array: [ {name: :a1, value: 'a1-value'},
                      {name: :a2, value: 'a2-value', nothing: nil},
                      {name: :a3, value: 'a3-value', errors: ['a3-error1', 'a3-error2']}
        ],
        mixed_array: [ 1, 2, 3, {a:1, b:2, c:3, d: nil}, [{a:1}, {b:2}, {c: 3}, nil], nil, [nil], [] ],
        mixed_hash: { c1: 1, c2: [1,2,3, nil], c3: {a:1, b:2, c:3, d: nil}, c4: nil, c5: [nil], c6:[] },
        nilly: nil,
        crazy_nested: {a: {b: [:c, {d: {e: [:f, {g: 'g', i: [:j, :k, {l: 'l'}]}]}}]}}
      }
    end

    it "matches hashes containing shuffled arrays" do
      actual[:hash_array].shuffle!
      actual[:mixed_array].shuffle!
      actual[:mixed_hash][:c2].shuffle!
      actual[:crazy_nested][:a][:b][1][:d][:e][1][:i].shuffle!
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements" do
      actual[:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements nested in arrays" do
      actual[:hash_array] << {fire: 'this_is_fine'}
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements nested in subhashes" do
      actual[:mixed_hash][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements double nested in arrays" do
      actual[:mixed_array] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements double nested in array then subhash" do
      actual[:hash_array][0][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements double nested in subhash then array" do
      actual[:mixed_hash][:c2] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing extra elements double nested in subhashes" do
      actual[:mixed_hash][:c3][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches hashes containing ridiculously nested extra elements" do
      actual[:crazy_nested][:a][:b][1][:d][:e][1][:i] << [:fire, 'this_is_fine']
      actual[:crazy_nested][:a][:b][1][:d][:fire] = [:fire, 'this_is_also_fine']
      expect(actual).to deep_include expected
    end

    # ===== FAILURES =====

    it "fails hashes missing an element" do
      actual.delete(:hash_array)
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements nested in arrays" do
      actual[:hash_array].pop
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements nested in subhashes" do
      actual[:mixed_hash].delete(:c1)
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements double nested in arrays" do
      actual[:mixed_array][4].pop
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements double nested in array then subhash" do
      actual[:mixed_array][3].delete(:c)
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements double nested in subhash then array" do
      actual[:mixed_hash][:c2].pop
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing elements double nested in subhashes" do
      actual[:mixed_hash][:c3].delete(:d)
      expect(actual).not_to deep_include expected
    end

    it "fails hashes missing ridiculously nested elements" do
      actual[:crazy_nested][:a][:b][1][:d][:e][1][:i].pop
      expect(actual).not_to deep_include expected
    end
  end

  context "given complex array expectation" do
    let(:expected) do
      [
        [ {name: :a1, value: 'a1-value'},
          {name: :a2, value: 'a2-value', nothing: nil},
          {name: :a3, value: 'a3-value', errors: ['a3-error1', 'a3-error2']}
        ],
        [ 1, 2, 3, {a:1, b:2, c:3, d: nil}, [{a:1}, {b:2}, {c: 3}, nil], nil, [nil], [] ],
        { c1: 1, c2: [1,2,3, nil], c3: {a:1, b:2, c:3, d: nil}, c4: nil, c5: [nil], c6:[] },
        nil,
        {a: {b: [:c, {d: {e: [:f, {g: 'g', i: [:j, :k, {l: 'l'}]}]}}]}}
      ]
    end

    it "matches shuffled arrays" do
      actual.shuffle!
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements" do
      actual << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements nested in arrays" do
      actual[0] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements nested in subhashes" do
      actual[2][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements double nested in arrays" do
      actual[1][4] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements double nested in array then subhash" do
      actual[1][3][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements double nested in subhash then array" do
      actual[2][:c2] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing extra elements double nested in subhashes" do
      actual[2][:c3][:fire] = [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    it "matches arrays containing ridiculously nested extra elements" do
      actual[4][:a][:b][1][:d][:e][1][:i] << [:fire, 'this_is_fine']
      expect(actual).to deep_include expected
    end

    # ===== FAILURES =====

    it "fails arrays missing an element" do
      actual.pop
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements nested in arrays" do
      actual[0].pop
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements nested in subhashes" do
      actual[2].delete(:c1)
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements double nested in arrays" do
      actual[1][4].pop
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements double nested in array then subhash" do
      actual[1][3].delete(:c)
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements double nested in subhash then array" do
      actual[2][:c2].pop
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing elements double nested in subhashes" do
      actual[2][:c3].delete(:d)
      expect(actual).not_to deep_include expected
    end

    it "fails arrays missing ridiculously nested elements" do
      actual[4][:a][:b][1][:d][:e][1][:i].pop
      expect(actual).not_to deep_include expected
    end
  end

  def deep_clone(x)
    case x
      when Array
        return x.map{|item| deep_clone(item)}
      when Hash
        return Hash[x.map{ |k,v| [k, deep_clone(v)] }]
      else
        return x.clone rescue x
    end
  end
end
