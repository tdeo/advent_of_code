# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_two_steps_forward')

class TwoStepsForwardTest < Minitest::Test
  def described_class = TwoStepsForward

  def test_part1_0
    assert_nil described_class.new('hijkl').part1
  end

  def test_part1_1
    assert_equal 'DDRRRD', described_class.new('ihgpwlah').part1
  end

  def test_part1_2
    assert_equal 'DDUDRLRRUDRD', described_class.new('kglvqrro').part1
  end

  def test_part1_3
    assert_equal 'DRURDRUDDLLDLUURRDULRLDUUDDDRR', described_class.new('ulqzkmiv').part1
  end

  def test_part2_1
    assert_equal 370, described_class.new('ihgpwlah').part2
  end

  def test_part2_2
    assert_equal 492, described_class.new('kglvqrro').part2
  end

  def test_part2_3
    assert_equal 830, described_class.new('ulqzkmiv').part2
  end
end
