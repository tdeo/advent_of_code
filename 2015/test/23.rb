# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/23_turing_lock')

describe TuringLock do
  before { @k = TuringLock }

  def test_part1
    assert_equal 2, @k.new('inc b
jio b, +2
tpl b
inc b').part1
  end
end
