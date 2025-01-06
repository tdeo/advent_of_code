# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/25_code_chronicle')

class CodeChronicleTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(CodeChronicle)) }
  def described_class = CodeChronicle

  sig { returns(String) }
  def input = <<~INPUT
    #####
    .####
    .####
    .####
    .#.#.
    .#...
    .....

    #####
    ##.##
    .#.##
    ...##
    ...#.
    ...#.
    .....

    .....
    #....
    #....
    #...#
    #.#.#
    #.###
    #####

    .....
    .....
    #.#..
    ###..
    ###.#
    ###.#
    #####

    .....
    .....
    .....
    #....
    #.#..
    #.#.#
    #####
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
