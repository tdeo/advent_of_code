# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_the_tyrannyofthe_rocket_equation')

class TheTyrannyoftheRocketEquationTest < Minitest::Test
  def described_class = TheTyrannyoftheRocketEquation

  def test_part1
    assert_equal(2 + 2 + 654 + 33_583, described_class.new('12
14
1969
100756').part1,)
  end

  def test_part2
    assert_equal(2, described_class.new('14').part2)
    assert_equal(966, described_class.new('1969').part2)
    assert_equal(2 + 966 + 50_346, described_class.new('14
1969
100756').part2,)
  end
end
