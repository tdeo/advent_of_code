# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_chronal_classification')

describe ChronalClassification do
  before { @k = ChronalClassification }

  def test_part1
    assert_equal 1, @k.new('Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]').part1
  end
end
