# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_chocolate_charts')

describe ChocolateCharts do
  before { @k = ChocolateCharts }

  def test_part1_1
    assert_equal '5158916779', @k.new('9').part1
  end

  def test_part1_2
    assert_equal '0124515891', @k.new('5').part1
  end

  def test_part1_3
    assert_equal '9251071085', @k.new('18').part1
  end

  def test_part1_4
    assert_equal '5941429882', @k.new('2018').part1
  end

  def test_part2_1
    assert_equal 9, @k.new('51589').part2
  end

  def test_part2_2
    assert_equal 5, @k.new('01245').part2
  end

  def test_part2_3
    assert_equal 18, @k.new('92510').part2
  end

  def test_part2_4
    assert_equal 2018, @k.new('59414').part2
  end
end
