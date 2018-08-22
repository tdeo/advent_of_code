require 'minitest/autorun'
require_relative('../lib/15_timing.rb')

describe Timing do
  before { @k = Timing }

  def test_part1
    assert_equal 5, @k.new('Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.').part1
  end
end

