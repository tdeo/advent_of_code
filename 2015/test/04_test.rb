# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/04_stocking_stuffer')

class StockingStufferTest < Minitest::Test
  def described_class = StockingStuffer

  def test_part1
    slow_test!

    assert_equal 609_043, described_class.new('abcdef').part1
    assert_equal 1_048_970, described_class.new('pqrstuv').part1
  end
end
