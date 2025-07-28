# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_one_time_pad')

class OneTimePadTest < Minitest::Test
  def described_class = OneTimePad

  def test_part1
    assert_equal 22_728, described_class.new('abc').part1
  end
end
