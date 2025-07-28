# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_hex')

class HexTest < Minitest::Test
  def described_class = Hex

  def test_part1_1
    assert_equal 3, described_class.new('ne,ne,ne').part1
  end

  def test_part1_2
    assert_equal 0, described_class.new('ne,ne,sw,sw').part1
  end

  def test_part1_3
    assert_equal 2, described_class.new('ne,ne,s,s').part1
  end

  def test_part1_4
    assert_equal 3, described_class.new('se,sw,se,sw,sw').part1
  end
end
