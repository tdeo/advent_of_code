# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/13_pointof_incidence')

class PointofIncidenceTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(PointofIncidence)) }
  def described_class = PointofIncidence

  sig { returns(String) }
  def input = <<~INPUT
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
  INPUT

  sig { void }
  def test_part1
    assert_equal 405, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 400, described_class.new(input).part2
  end
end
