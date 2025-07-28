# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_no_such_thing_as_too_much')

class NoSuchThingAsTooMuchTest < Minitest::Test
  def described_class = NoSuchThingAsTooMuch

  def test_part1
    assert_equal 4, described_class.new('20
15
10
5
5').part1(25)
  end

  def test_part2
    assert_equal 3, described_class.new('20
15
10
5
5').part2(25)
  end
end
