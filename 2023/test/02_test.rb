# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/02_cube_conundrum')

class CubeConundrumTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(CubeConundrum)) }
  def described_class = CubeConundrum

  sig { returns(String) }
  def input = <<~INPUT
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  INPUT

  sig { void }
  def test_part1
    assert_equal 8, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2286, described_class.new(input).part2
  end
end
