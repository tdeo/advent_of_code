# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_nice_strings')

class NiceStringsTest < Minitest::Test
  def described_class = NiceStrings

  def test_part1
    assert_equal 1, described_class.new('ugknbfddgicrmopn').part1
    assert_equal 1, described_class.new('aaa').part1
    assert_equal 0, described_class.new('jchzalrnumimnmhp').part1
    assert_equal 0, described_class.new('haegwjzuvuyypxyu').part1
    assert_equal 0, described_class.new('dvszwmarrgswjxmb').part1
  end

  def test_part2
    assert_equal 1, described_class.new('qjhvhtzxzqqjkmpb').part2
    assert_equal 1, described_class.new('xxyxx').part2
    assert_equal 0, described_class.new('uurcxstgmygtbstg').part2
    assert_equal 0, described_class.new('ieodomkazucvgmuy').part2
  end
end
