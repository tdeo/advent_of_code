# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/25_combo_breaker')

class ComboBreakerTest < Minitest::Test
  def described_class = ComboBreaker

  def test_part1
    assert_equal 14_897_079, described_class.new(<<~INPUT).part1
      5764801
      17807724
    INPUT
  end

  def test_part2
    assert described_class.new('').part2
  end
end
