# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_science_for_hungry_people')

describe ScienceForHungryPeople do
  before { @k = ScienceForHungryPeople }

  def test_part1
    assert_equal 62_842_880, @k.new('Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3').part1
  end

  def test_part2
    assert_equal 57_600_000, @k.new('Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3').part2
  end
end
