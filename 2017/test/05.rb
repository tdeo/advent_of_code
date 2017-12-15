require 'minitest/autorun'
require_relative '../lib/05_maze_trampolines.rb'

class MazeTrampolinesTest < MiniTest::Test
  def test_part1_1
    assert_equal 5, MazeTrampolines.new('0
3
0
1
-3').part1
  end

  def test_part2_1
    assert_equal 10, MazeTrampolines.new('0
3
0
1
-3').part2
  end
end
