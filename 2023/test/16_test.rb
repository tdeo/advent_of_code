# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/16_the_floor_will_be_lava')

class TheFloorWillBeLavaTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(TheFloorWillBeLava)) }
  def described_class = TheFloorWillBeLava

  sig { returns(String) }
  def input = <<~INPUT
    .|...\\....
    |.-.\\.....
    .....|-...
    ........|.
    ..........
    .........\\
    ..../.\\\\..
    .-.-/..|..
    .|....-|.\\
    ..//.|....
  INPUT

  sig { void }
  def test_part1
    assert_equal 46, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 51, described_class.new(input).part2
  end
end
