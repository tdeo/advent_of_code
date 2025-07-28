# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_single_night')

class SingleNightTest < Minitest::Test
  def described_class = SingleNight

  def test_part1
    assert_equal 605, described_class.new('London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141').part1
  end

  def test_part2
    assert_equal 982, described_class.new('London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141').part2
  end
end
