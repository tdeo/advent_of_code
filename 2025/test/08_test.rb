# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/08_playground')

class PlaygroundTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Playground)) }
  def described_class = Playground

  sig { returns(String) }
  def input = <<~INPUT
    162,817,812
    57,618,57
    906,360,560
    592,479,940
    352,342,300
    466,668,158
    542,29,236
    431,825,988
    739,650,466
    52,470,668
    216,146,977
    819,987,18
    117,168,530
    805,96,715
    346,949,466
    970,615,88
    941,993,340
    862,61,35
    984,92,344
    425,690,689
  INPUT

  sig { void }
  def test_part1
    assert_equal 40, described_class.new(input).part1(count: 10)
  end

  sig { void }
  def test_part2
    assert_equal 25_272, described_class.new(input).part2
  end
end
