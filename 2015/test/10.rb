# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/10_elves')

describe Elves do
  before { @k = Elves }

  def test_part1
    assert_equal '11'.size, @k.new('1').part1(1)
    assert_equal '312211'.size, @k.new('1').part1(5)
  end
end
