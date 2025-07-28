# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/23_amphipod')

class AmphipodTest < Minitest::Test
  def described_class = Amphipod
  def input = <<~INPUT
    #############
    #...........#
    ###B#C#B#D###
      #A#D#C#A#
      #########
  INPUT

  def test_part1
    assert_equal 12_521, described_class.new(input).part1
  end

  def test_part2
    assert_equal 44_169, described_class.new(input).part2
  end
end
