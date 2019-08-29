require 'minitest/autorun'
require_relative('../lib/20_infinite_elves.rb')

describe InfiniteElves do
  before { @k = InfiniteElves }

  def test_part1
    assert_equal 6, @k.new('100').part1
  end
end
