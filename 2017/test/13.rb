require 'minitest/autorun'
require_relative('../lib/13_scanners.rb')

describe Scanners do
  before { @k = Scanners }

  def test_part1
    assert_equal 24, @k.new('0: 3
1: 2
4: 4
6: 4').part1
  end

  def test_part2
    assert_equal 10, @k.new('0: 3
1: 2
4: 4
6: 4').part2
  end
end
