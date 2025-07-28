# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/13_scanners')

class ScannersTest < Minitest::Test
  def described_class = Scanners

  def test_part1
    assert_equal 24, described_class.new('0: 3
1: 2
4: 4
6: 4').part1
  end

  def test_part2
    assert_equal 10, described_class.new('0: 3
1: 2
4: 4
6: 4').part2
  end
end
