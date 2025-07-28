# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_defrag')

class DefragTest < Minitest::Test
  def described_class = Defrag

  def test_part1
    assert_equal 8108, described_class.new('flqrgnkx').part1
  end

  def test_part2
    assert_equal 1242, described_class.new('flqrgnkx').part2
  end
end
