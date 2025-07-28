# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_wrapping_paper')

class WrappingPaperTest < Minitest::Test
  def described_class = WrappingPaper

  def test_part1
    assert_equal 58, described_class.new('2x3x4').part1
    assert_equal 43, described_class.new('1x1x10').part1
  end

  def test_part2
    assert_equal 34, described_class.new('2x3x4').part2
    assert_equal 14, described_class.new('1x1x10').part2
  end
end
