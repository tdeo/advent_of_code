require 'minitest/autorun'
require_relative('../lib/05_chess.rb')

describe Chess do
  before { @k = Chess }

  def test_part1
    assert_equal '18f47a30', @k.new('abc').part1
  end

  def test_part2
    assert_equal '05ace8e3', @k.new('abc').part2
  end
end
