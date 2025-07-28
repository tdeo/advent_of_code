# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_balance')

class BalanceTest < Minitest::Test
  def described_class = Balance

  def test_part1
    assert_equal 99, described_class.new("1\n2\n3\n4\n5\n7\n8\n9\n10\n11").part1
  end

  def test_part2
    assert_equal 44, described_class.new("1\n2\n3\n4\n5\n7\n8\n9\n10\n11").part2
  end
end
