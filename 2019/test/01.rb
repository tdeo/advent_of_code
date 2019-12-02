require 'minitest/autorun'
require_relative('../lib/01_the_tyrannyofthe_rocket_equation.rb')

describe TheTyrannyoftheRocketEquation do
  before { @k = TheTyrannyoftheRocketEquation }

  def test_part1
    assert_equal(2 + 2 + 654 + 33583, @k.new('12
14
1969
100756').part1)
  end

  def test_part2
    assert_equal(2, @k.new('14').part2)
    assert_equal(966, @k.new('1969').part2)
    assert_equal(2 + 966 + 50346, @k.new('14
1969
100756').part2)
  end
end
