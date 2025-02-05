# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/17_clumsy_crucible')

class ClumsyCrucibleTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ClumsyCrucible)) }
  def described_class = ClumsyCrucible

  sig { returns(String) }
  def input = <<~INPUT
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
  INPUT

  sig { void }
  def test_part1
    assert_equal 102, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 94, described_class.new(input).part2
  end
end
