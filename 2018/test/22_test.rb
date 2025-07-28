# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_mode_maze')

class ModeMazeTest < Minitest::Test
  def described_class = ModeMaze

  def test_part1
    assert_equal 114, described_class.new('depth: 510
target: 10,10').part1
  end

  def test_part2
    assert_equal 45, described_class.new('depth: 510
target: 10,10').part2
  end
end
