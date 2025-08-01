# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_sunnywitha_chanceof_asteroids')

class SunnywithaChanceofAsteroidsTest < Minitest::Test
  def described_class = SunnywithaChanceofAsteroids

  def test_part2
    assert_equal 0, described_class.new('3,9,8,9,10,9,4,9,99,-1,8').sendint(7).part1
    assert_equal 1, described_class.new('3,9,8,9,10,9,4,9,99,-1,8').sendint(8).part1
    assert_equal 0, described_class.new('3,9,8,9,10,9,4,9,99,-1,8').sendint(9).part1

    assert_equal 1, described_class.new('3,9,7,9,10,9,4,9,99,-1,8').sendint(7).part1
    assert_equal 0, described_class.new('3,9,7,9,10,9,4,9,99,-1,8').sendint(8).part1
    assert_equal 0, described_class.new('3,9,7,9,10,9,4,9,99,-1,8').sendint(9).part1

    assert_equal 0, described_class.new('3,3,1108,-1,8,3,4,3,99').sendint(7).part1
    assert_equal 1, described_class.new('3,3,1108,-1,8,3,4,3,99').sendint(8).part1
    assert_equal 0, described_class.new('3,3,1108,-1,8,3,4,3,99').sendint(9).part1

    assert_equal 1, described_class.new('3,3,1107,-1,8,3,4,3,99').sendint(7).part1
    assert_equal 0, described_class.new('3,3,1107,-1,8,3,4,3,99').sendint(8).part1
    assert_equal 0, described_class.new('3,3,1107,-1,8,3,4,3,99').sendint(9).part1

    assert_equal 999, described_class.new('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99').sendint(7).part1
    assert_equal 1000, described_class.new('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99').sendint(8).part1
    assert_equal 1001, described_class.new('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99').sendint(9).part1
  end
end
