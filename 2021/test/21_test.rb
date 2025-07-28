# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/21_dirac_dice')

class DiracDiceTest < Minitest::Test
  def described_class = DiracDice

  def input = <<~INPUT
    Player 1 starting position: 4
    Player 2 starting position: 8
  INPUT

  def test_part1
    assert_equal 739_785, described_class.new(input).part1
  end

  def test_part2
    slow_test!

    assert_equal 444_356_092_776_315, described_class.new(input).part2
  end
end
