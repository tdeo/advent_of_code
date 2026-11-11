# frozen_string_literal: true

require 'test/test_helper'
require_relative('../lib/17_spinlock')

class SpinlockTest < Minitest::Test
  def described_class = Spinlock

  def test_part1
    assert_equal 638, described_class.new(3).part1
  end
end
