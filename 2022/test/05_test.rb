# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/05_supply_stacks')

class SupplyStacksTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(SupplyStacks)) }
  def described_class = SupplyStacks

  sig { returns(String) }
  def input = <<~INPUT
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
  INPUT

  sig { void }
  def test_part1
    assert_equal 'CMZ', described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 'MCD', described_class.new(input).part2
  end
end
