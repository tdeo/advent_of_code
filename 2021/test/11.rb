# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_dumbo_octopus')

describe DumboOctopus do
  before { @k = DumboOctopus }

  def test_part1
    assert_equal 1656, @k.new(<<~INPUT).part1
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    INPUT
  end

  def test_part2
    assert_equal 195, @k.new(<<~INPUT).part2
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    INPUT
  end
end
