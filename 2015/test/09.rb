# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_single_night')

describe SingleNight do
  before { @k = SingleNight }

  def test_part1
    assert_equal 605, @k.new('London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141').part1
  end

  def test_part2
    assert_equal 982, @k.new('London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141').part2
  end
end
