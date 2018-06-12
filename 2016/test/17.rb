require 'minitest/autorun'
require_relative('../lib/17_two_steps_forward.rb')

describe TwoStepsForward do
  before { @k = TwoStepsForward }

  def test_part1_0
    assert_nil @k.new('hijkl').part1
  end

  def test_part1_1
    assert_equal 'DDRRRD', @k.new('ihgpwlah').part1
  end

  def test_part1_2
    assert_equal 'DDUDRLRRUDRD', @k.new('kglvqrro').part1
  end

  def test_part1_3
    assert_equal 'DRURDRUDDLLDLUURRDULRLDUUDDDRR', @k.new('ulqzkmiv').part1
  end

  def test_part2_1
    assert_equal 370, @k.new('ihgpwlah').part2
  end

  def test_part2_2
    assert_equal 492, @k.new('kglvqrro').part2
  end

  def test_part2_3
    assert_equal 830, @k.new('ulqzkmiv').part2
  end
end

