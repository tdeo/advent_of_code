# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/25_combo_breaker')

describe ComboBreaker do
  before { @k = ComboBreaker }

  def test_part1
    assert_equal 14_897_079, @k.new(<<~INPUT).part1
      5764801
      17807724
    INPUT
  end

  def test_part2
    assert_equal true, @k.new('').part2
  end
end
