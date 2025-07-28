# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/10_elves')

class ElvesTest < Minitest::Test
  def described_class = Elves

  def test_part1
    assert_equal 2, described_class.new('1').part1(1)
    assert_equal 6, described_class.new('1').part1(5)
  end
end
