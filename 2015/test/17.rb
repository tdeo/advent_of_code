# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_no_such_thing_as_too_much')

describe NoSuchThingAsTooMuch do
  before { @k = NoSuchThingAsTooMuch }

  def test_part1
    assert_equal 4, @k.new('20
15
10
5
5').part1(25)
  end

  def test_part2
    assert_equal 3, @k.new('20
15
10
5
5').part2(25)
  end
end
