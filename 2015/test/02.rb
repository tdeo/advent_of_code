require 'minitest/autorun'
require_relative('../lib/02_wrapping_paper.rb')

describe WrappingPaper do
  before { @k = WrappingPaper }

  def test_part1
    assert_equal 58, @k.new('2x3x4').part1
    assert_equal 43, @k.new('1x1x10').part1
  end

  def test_part2
    assert_equal 34, @k.new('2x3x4').part2
    assert_equal 14, @k.new('1x1x10').part2
  end
end
