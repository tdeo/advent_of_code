require 'minitest/autorun'
require_relative('../lib/14_one_time_pad.rb')

describe OneTimePad do
  before { @k = OneTimePad }

  def test_part1
    assert_equal 22728, @k.new('abc').part1
  end
end

