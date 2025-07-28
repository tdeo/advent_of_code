# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_alchemical_reaction')

class AlchemicalReactionTest < Minitest::Test
  def described_class = AlchemicalReaction

  def test_part1_1
    assert_equal 0, described_class.new('aA').part1
  end

  def test_part1_2
    assert_equal 0, described_class.new('abBA').part1
  end

  def test_part1_3
    assert_equal 4, described_class.new('abAB').part1
  end

  def test_part1_4
    assert_equal 6, described_class.new('aabAAB').part1
  end

  def test_part1_5
    assert_equal 10, described_class.new('dabAcCaCBAcCcaDA').part1
  end

  def test_part2
    assert_equal 4, described_class.new('dabAcCaCBAcCcaDA').part2
  end
end
