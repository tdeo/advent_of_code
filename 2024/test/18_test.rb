# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/18_ram_run')

class RamRunTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RamRun)) }
  def described_class = RamRun

  sig { returns(String) }
  def input = <<~INPUT
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
  INPUT

  sig { void }
  def test_part1
    assert_equal 22, described_class.new(input, upto: 6).part1(byte_count: 12)
  end

  sig { void }
  def test_part2
    assert_equal '6,1', described_class.new(input, upto: 6).part2
  end
end
