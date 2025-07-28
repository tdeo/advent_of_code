# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/23_safe_cracking')

class SafeCrackingTest < Minitest::Test
  def described_class = SafeCracking

  def test_part1
    assert_equal 3, described_class.new('cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a').part1
  end
end
