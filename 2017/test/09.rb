# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_stream')

describe Stream do
  before { @k = Stream }

  def test_part1_1
    assert_equal 1, @k.new('{}').part1
  end

  def test_part1_2
    assert_equal 6, @k.new('{{{}}}').part1
  end

  def test_part1_3
    assert_equal 5, @k.new('{{},{}}').part1
  end

  def test_part1_4
    assert_equal 16, @k.new('{{{},{},{{}}}}').part1
  end

  def test_part1_5
    assert_equal 1, @k.new('{<a>,<a>,<a>,<a>}').part1
  end

  def test_part1_6
    assert_equal 9, @k.new('{{<ab>},{<ab>},{<ab>},{<ab>}}').part1
  end

  def test_part1_7
    assert_equal 9, @k.new('{{<!!>},{<!!>},{<!!>},{<!!>}}').part1
  end

  def test_part1_8
    assert_equal 3, @k.new('{{<a!>},{<a!>},{<a!>},{<ab>}}').part1
  end

  def test_part2_1
    assert_equal 0, @k.new('<>').part2
  end

  def test_part2_2
    assert_equal 17, @k.new('<random characters>').part2
  end

  def test_part2_3
    assert_equal 3, @k.new('<<<<>').part2
  end

  def test_part2_4
    assert_equal 2, @k.new('<{!>}>').part2
  end

  def test_part2_5
    assert_equal 0, @k.new('<!!>').part2
  end

  def test_part2_6
    assert_equal 0, @k.new('<!!!>>').part2
  end

  def test_part2_7
    assert_equal 10, @k.new('{<{o"i!a,<{i<a>,{}}').part2
  end
end
