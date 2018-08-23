require 'minitest/autorun'
require_relative('../lib/05_chess.rb')

describe Chess do
  before { @k = Chess }

  def test_part1
    assert_equal '18f4', @k.new('abc').part1(4)
  end

  def test_part2
    assert_equal '05ac', @k.new('abc').part2(4)
  end
end
