# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_binary_boarding')

class BinaryBoardingTest < Minitest::Test
  def described_class = BinaryBoarding

  def test_seatid
    assert_equal 357, described_class.new('').seat_id('FBFBBFFRLR')
    assert_equal 567, described_class.new('').seat_id('BFFFBBFRRR')
    assert_equal 119, described_class.new('').seat_id('FFFBBBFRRR')
    assert_equal 820, described_class.new('').seat_id('BBFFBBFRLL')
  end
end
