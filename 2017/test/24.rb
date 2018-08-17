require 'minitest/autorun'
require_relative('../lib/24_electromagnetic_moat.rb')

describe ElectromagneticMoat do
  before { @k = ElectromagneticMoat }

  def test_part1
    assert_equal 31, @k.new('0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10').part1
  end

  def test_part2
    assert_equal 19, @k.new('0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10').part2
  end
end
