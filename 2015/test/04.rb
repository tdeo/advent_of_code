# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/04_stocking_stuffer')

describe StockingStuffer do
  before { @k = StockingStuffer }

  def test_part1
    assert_equal 609_043, @k.new('abcdef').part1
    assert_equal 1_048_970, @k.new('pqrstuv').part1
  end
end
