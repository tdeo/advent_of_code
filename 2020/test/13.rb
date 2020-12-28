require 'minitest/autorun'
require_relative('../lib/13_shuttle_search.rb')

describe ShuttleSearch do
  before { @k = ShuttleSearch }

  def test_part1
    assert_equal 295, @k.new('939
7,13,x,x,59,x,31,19').part1
  end

  def test_part2
    assert_equal 1068781, @k.new('939
7,13,x,x,59,x,31,19').part2
  end

  def test_part2_1
    assert_equal 3417, @k.new('1
17,x,13,19').part2
  end

  def test_part2_2
    assert_equal 754018, @k.new('1
67,7,59,61').part2
  end

  def test_part2_3
    assert_equal 779210, @k.new('1
67,x,7,59,61').part2
  end

  def test_part2_4
    assert_equal 1261476, @k.new('1
67,7,x,59,61').part2
  end

  def test_part2_5
    assert_equal 1202161486, @k.new('1
1789,37,47,1889').part2
  end
end
