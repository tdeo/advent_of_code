# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/13_cubicles')

class CubiclesTest < Minitest::Test
  def described_class = Cubicles

  def test_demo
    assert_equal 11, described_class.new('10').demo
  end
end
