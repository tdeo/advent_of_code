# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_timing')

class TimingTest < Minitest::Test
  def described_class = Timing

  def test_part1
    assert_equal 5, described_class.new('Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.').part1
  end
end
