# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/08_matchsticks')

class MatchsticksTest < Minitest::Test
  def described_class = Matchsticks

  def test_part1
    assert_equal 12, described_class.new('""
"abc"
"aaa\"aaa"
"\x27"').part1
  end

  def test_part2
    assert_equal 19, described_class.new('""
"abc"
"aaa\"aaa"
"\x27"').part2
  end
end
