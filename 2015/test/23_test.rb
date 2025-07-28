# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/23_turing_lock')

class TuringLockTest < Minitest::Test
  def described_class = TuringLock

  def test_part1
    assert_equal 2, described_class.new('inc b
jio b, +2
tpl b
inc b').part1
  end
end
