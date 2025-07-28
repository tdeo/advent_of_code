# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_generators')

class GeneratorsTest < Minitest::Test
  def described_class = Generators

  def test_part1
    slow_test!

    assert_equal 588, described_class.new('Gen A 65
      Gen B 8921').part1
  end

  def test_part2
    slow_test!

    assert_equal 309, described_class.new('Gen A 65
      Gen B 8921').part2
  end
end
