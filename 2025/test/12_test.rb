# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/12_christmas_tree_farm')

class ChristmasTreeFarmTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ChristmasTreeFarm)) }
  def described_class = ChristmasTreeFarm

  sig { returns(String) }
  def input = <<~INPUT
    0:
    ###
    ##.
    ##.

    1:
    ###
    ##.
    .##

    2:
    .##
    ###
    ##.

    3:
    ##.
    ###
    ##.

    4:
    ###
    #..
    ###

    5:
    ###
    .#.
    ###

    4x4: 0 0 0 0 2 0
    12x5: 1 0 1 0 2 2
    12x5: 1 0 1 0 3 2
  INPUT

  sig { void }
  def test_part1
    assert_equal 3, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 0, described_class.new(input).part2
  end
end
