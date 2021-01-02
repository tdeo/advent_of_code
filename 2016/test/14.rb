# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_one_time_pad')

describe OneTimePad do
  before { @k = OneTimePad }

  def test_part1
    assert_equal 22_728, @k.new('abc').part1
  end
end
