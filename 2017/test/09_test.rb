# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_stream')

class StreamTest < Minitest::Test
  def described_class = Stream

  def test_part1_1
    assert_equal 1, described_class.new('{}').part1
  end

  def test_part1_2
    assert_equal 6, described_class.new('{{{}}}').part1
  end

  def test_part1_3
    assert_equal 5, described_class.new('{{},{}}').part1
  end

  def test_part1_4
    assert_equal 16, described_class.new('{{{},{},{{}}}}').part1
  end

  def test_part1_5
    assert_equal 1, described_class.new('{<a>,<a>,<a>,<a>}').part1
  end

  def test_part1_6
    assert_equal 9, described_class.new('{{<ab>},{<ab>},{<ab>},{<ab>}}').part1
  end

  def test_part1_7
    assert_equal 9, described_class.new('{{<!!>},{<!!>},{<!!>},{<!!>}}').part1
  end

  def test_part1_8
    assert_equal 3, described_class.new('{{<a!>},{<a!>},{<a!>},{<ab>}}').part1
  end

  def test_part2_1
    assert_equal 0, described_class.new('<>').part2
  end

  def test_part2_2
    assert_equal 17, described_class.new('<random characters>').part2
  end

  def test_part2_3
    assert_equal 3, described_class.new('<<<<>').part2
  end

  def test_part2_4
    assert_equal 2, described_class.new('<{!>}>').part2
  end

  def test_part2_5
    assert_equal 0, described_class.new('<!!>').part2
  end

  def test_part2_6
    assert_equal 0, described_class.new('<!!!>>').part2
  end

  def test_part2_7
    assert_equal 10, described_class.new('{<{o"i!a,<{i<a>,{}}').part2
  end
end
