require 'minitest/autorun'
require_relative('../lib/21_springdroid_adventure.rb')

describe SpringdroidAdventure do
  before { @k = SpringdroidAdventure }

  def test_part1
    assert_equal true, @k.new('input').part1
  end

  def test_part2
    assert_equal true, @k.new('input').part2
  end
end
