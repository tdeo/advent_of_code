# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/25_four_dimensional_adventure')

class FourDimensionalAdventureTest < Minitest::Test
  def described_class = FourDimensionalAdventure

  def test_part1
    assert_equal 2, described_class.new(' 0,0,0,0
 3,0,0,0
 0,3,0,0
 0,0,3,0
 0,0,0,3
 0,0,0,6
 9,0,0,0
12,0,0,0').part1
  end

  def test_part1_2
    assert_equal 4, described_class.new('-1,2,2,0
0,0,2,-2
0,0,0,-2
-1,2,0,0
-2,-2,-2,2
3,0,2,-1
-1,3,2,2
-1,0,-1,0
0,2,1,-2
3,0,0,0').part1
  end

  def test_part1_3
    assert_equal 3, described_class.new('1,-1,0,1
2,0,-1,0
3,2,-1,0
0,0,3,1
0,0,-1,-1
2,3,-2,0
-2,2,0,0
2,-2,0,-1
1,-1,0,-1
3,2,0,2').part1
  end

  def test_part1_4
    assert_equal 8, described_class.new('1,-1,-1,-2
-2,-2,0,1
0,2,1,3
-2,3,-2,1
0,2,3,-2
-1,-1,1,-2
0,-2,-1,0
-2,2,3,-1
1,2,2,0
-1,-2,0,-2').part1
  end
end
