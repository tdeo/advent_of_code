# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_bathroom')

class BathroomTest < Minitest::Test
  def described_class = Bathroom

  def test_part1
    assert_equal '1985', described_class.new('ULL
      RRDDD
      LURDL
      UUUUD').part1
  end

  def test_part2
    assert_equal '5DB3', described_class.new('ULL
      RRDDD
      LURDL
      UUUUD').part2
  end
end
