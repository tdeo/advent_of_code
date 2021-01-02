# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_js_abacus_framework')

describe JsAbacusFramework do
  before { @k = JsAbacusFramework }

  def test_part1
    assert_equal 6, @k.new('[1,2,3]').part1
    assert_equal 6, @k.new('{"a":2,"b":4}').part1
    assert_equal 3, @k.new('[[[3]]]').part1
    assert_equal 3, @k.new('"a":{"b":4},"c":-1}').part1
    assert_equal 0, @k.new('{"a":[-1,1]}').part1
    assert_equal 0, @k.new('[-1,{"a":1}]').part1
    assert_equal 0, @k.new('[]').part1
    assert_equal 0, @k.new('{}').part1
  end

  def test_part2
    assert_equal 6, @k.new('[1,2,3]').part1
    assert_equal 4, @k.new('[1,{"c":"red","b":2},3]').part2
    assert_equal 0, @k.new('{"d":"red","e":[1,2,3,4],"f":5}').part2
    assert_equal 6, @k.new('[1,"red",5]').part1
  end
end
