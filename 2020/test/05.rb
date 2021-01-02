# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_binary_boarding')

describe BinaryBoarding do
  before { @k = BinaryBoarding }

  def test_seatid
    assert_equal 357, @k.new('').seat_id('FBFBBFFRLR')
    assert_equal 567, @k.new('').seat_id('BFFFBBFRRR')
    assert_equal 119, @k.new('').seat_id('FFFBBBFRRR')
    assert_equal 820, @k.new('').seat_id('BBFFBBFRLL')
  end
end
