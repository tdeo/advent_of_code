# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_ticket_translation')

class TicketTranslationTest < Minitest::Test
  def described_class = TicketTranslation

  def test_part1
    assert_equal 71, described_class.new('class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12').part1
  end

  def test_part2
    assert_equal 12 * 11, described_class.new('class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9').part2(/(class|row)/)
  end

  def test_part2_2
    assert_equal 12 * 13, described_class.new('class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9').part2(/(class|seat)/)
  end
end
