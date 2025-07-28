# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_calorie_counting')

class CalorieCountingTest < Minitest::Test
  def described_class = CalorieCounting

  def input = <<~INPUT
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
  INPUT

  def test_part1
    assert_equal 24_000, described_class.new(input).part1
  end

  def test_part2
    assert_equal 45_000, described_class.new(input).part2
  end
end
