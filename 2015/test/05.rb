# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_nice_strings')

describe NiceStrings do
  before { @k = NiceStrings }

  def test_part1
    assert_equal 1, @k.new('ugknbfddgicrmopn').part1
    assert_equal 1, @k.new('aaa').part1
    assert_equal 0, @k.new('jchzalrnumimnmhp').part1
    assert_equal 0, @k.new('haegwjzuvuyypxyu').part1
    assert_equal 0, @k.new('dvszwmarrgswjxmb').part1
  end

  def test_part2
    assert_equal 1, @k.new('qjhvhtzxzqqjkmpb').part2
    assert_equal 1, @k.new('xxyxx').part2
    assert_equal 0, @k.new('uurcxstgmygtbstg').part2
    assert_equal 0, @k.new('ieodomkazucvgmuy').part2
  end
end
