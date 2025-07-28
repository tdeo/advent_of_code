# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_not_quite_lisp')

class NotQuiteLispTest < Minitest::Test
  def described_class = NotQuiteLisp

  def test_part1
    assert_equal 0, described_class.new('(())').part1
    assert_equal 0, described_class.new('()()').part1
    assert_equal 3, described_class.new('(((').part1
    assert_equal 3, described_class.new('(()(()(').part1
    assert_equal 3, described_class.new('))(((((').part1
    assert_equal(-1, described_class.new('())').part1)
    assert_equal(-1, described_class.new('))(').part1)
  end

  def test_part2
    assert_equal 1, described_class.new(')').part2
    assert_equal 5, described_class.new('()())').part2
  end
end
