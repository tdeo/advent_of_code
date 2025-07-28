# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_chess')

class ChessTest < Minitest::Test
  def described_class = Chess

  def test_part1
    assert_equal '18f4', described_class.new('abc').part1(4)
  end

  def test_part2
    assert_equal '05ac', described_class.new('abc').part2(4)
  end
end
