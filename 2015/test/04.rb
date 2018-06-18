require 'minitest/autorun'
require_relative('../lib/04_stocking_stuffer.rb')

describe StockingStuffer do
  before { @k = StockingStuffer }

  def test_part1
    assert_equal 609043, @k.new('abcdef').part1
    assert_equal 1048970, @k.new('pqrstuv').part1
  end
end
