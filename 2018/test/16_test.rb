# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_chronal_classification')

class ChronalClassificationTest < Minitest::Test
  def described_class = ChronalClassification

  def test_part1
    assert_equal 1, described_class.new('Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]').part1
  end
end
