# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/02_corruption_checksum'

class CorruptionChecksumTest < Minitest::Test
  def test_part1_1
    assert_equal 18, CorruptionChecksum.new('5 1 9 5
7 5 3
2 4 6 8').part1
  end

  def test_part2_1
    assert_equal 9, CorruptionChecksum.new('5 9 2 8
9 4 7 3
3 8 6 5').part2
  end
end
