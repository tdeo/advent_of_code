# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/16_proboscidea_volcanium')

class ProboscideaVolcaniumTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(ProboscideaVolcanium)) }
  def described_class = ProboscideaVolcanium

  sig { returns(String) }
  def input = <<~INPUT
    Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
    Valve BB has flow rate=13; tunnels lead to valves CC, AA
    Valve CC has flow rate=2; tunnels lead to valves DD, BB
    Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
    Valve EE has flow rate=3; tunnels lead to valves FF, DD
    Valve FF has flow rate=0; tunnels lead to valves EE, GG
    Valve GG has flow rate=0; tunnels lead to valves FF, HH
    Valve HH has flow rate=22; tunnel leads to valve GG
    Valve II has flow rate=0; tunnels lead to valves AA, JJ
    Valve JJ has flow rate=21; tunnel leads to valve II
  INPUT

  sig { void }
  def test_part1
    assert_equal 1651, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 1707, described_class.new(input).part2
  end
end
