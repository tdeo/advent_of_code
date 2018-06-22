require 'minitest/autorun'
require_relative('../lib/20_infinite_elves.rb')

describe InfiniteElves do
  before { @k = InfiniteElves }

  def test_part1
    assert_equal answer, @k.new(input).part1
  end

  def test_part2
    assert_equal answer, @k.new(input).part2
  end
end
