# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_alchemical_reaction')

describe AlchemicalReaction do
  before { @k = AlchemicalReaction }

  def test_part1_1
    assert_equal 0, @k.new('aA').part1
  end

  def test_part1_2
    assert_equal 0, @k.new('abBA').part1
  end

  def test_part1_3
    assert_equal 4, @k.new('abAB').part1
  end

  def test_part1_4
    assert_equal 6, @k.new('aabAAB').part1
  end

  def test_part1_5
    assert_equal 10, @k.new('dabAcCaCBAcCcaDA').part1
  end

  def test_part2
    assert_equal 4, @k.new('dabAcCaCBAcCcaDA').part2
  end
end
