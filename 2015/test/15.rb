require 'minitest/autorun'
require_relative('../lib/15_science_for_hungry_people.rb')

describe ScienceForHungryPeople do
  before { @k = ScienceForHungryPeople }

  def test_part1
    assert_equal 62842880, @k.new('Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3').part1
  end

  def test_part2
    assert_equal 57600000, @k.new('Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3').part2
  end
end
