# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_operation_order')

class OperationOrderTest < Minitest::Test
  def described_class = OperationOrder

  def test_part1
    assert_equal 71, described_class.new('1 + 2 * 3 + 4 * 5 + 6').part1
    assert_equal 51, described_class.new('1 + (2 * 3) + (4 * (5 + 6))').part1
  end

  def test_part2
    assert_equal 231, described_class.new('1 + 2 * 3 + 4 * 5 + 6').part2
  end
end
