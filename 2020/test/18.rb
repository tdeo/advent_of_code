require 'minitest/autorun'
require_relative('../lib/18_operation_order.rb')

describe OperationOrder do
  before { @k = OperationOrder }

  def test_part1
    assert_equal 71, @k.new('1 + 2 * 3 + 4 * 5 + 6').part1
    assert_equal 51, @k.new('1 + (2 * 3) + (4 * (5 + 6))').part1
  end

  def test_part2
    assert_equal 231, @k.new('1 + 2 * 3 + 4 * 5 + 6').part2
  end
end
