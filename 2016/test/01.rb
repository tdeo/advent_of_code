require 'minitest/autorun'
require_relative('../lib/01_taxicab.rb')

describe Taxicab do
  before { @k = Taxicab }

  def test_part1_1
    assert_equal 5, @k.new('R2, L3').part1
  end

  def test_part1_2
    assert_equal 2, @k.new('R2, R2, R2').part1
  end

  def test_part1_3
    assert_equal 12, @k.new('R5, L5, R5, R3').part1
  end

  def test_part2
    assert_equal 4, @k.new('R8, R4, R4, R8').part2
  end
end
