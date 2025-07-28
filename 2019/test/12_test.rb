# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_the_n_body_problem')

class TheNBodyProblemTest < Minitest::Test
  def described_class = TheNBodyProblem

  def test_part1
    assert_equal 179, described_class.new('<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>').part1(10)
  end

  def test_part1b
    assert_equal 1940, described_class.new('<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>').part1(100)
  end

  def test_part2
    assert_equal 2772, described_class.new('<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>').part2
  end

  def test_part2b
    assert_equal 4_686_774_924, described_class.new('<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>').part2
  end
end
