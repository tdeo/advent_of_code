# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_chiton')

describe Chiton do
  let(:described_class) { Chiton }
  let(:input) { <<~INPUT }
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
  INPUT

  def test_part1
    assert_equal 40, described_class.new(input).part1
  end

  def test_part2
    assert_equal 315, described_class.new(input).part2
  end
end
