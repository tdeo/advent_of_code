# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/08_treetop_tree_house')

class TreetopTreeHouseTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(TreetopTreeHouse)) }
  def described_class = TreetopTreeHouse

  sig { returns(String) }
  def input = <<~INPUT
    30373
    25512
    65332
    33549
    35390
  INPUT

  sig { void }
  def test_part1
    assert_equal 21, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 8, described_class.new(input).part2
  end
end
