# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/21_keypad_conundrum')

class KeypadConundrumTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(KeypadConundrum)) }
  def described_class = KeypadConundrum

  sig { returns(String) }
  def input = <<~INPUT
    029A
    980A
    179A
    456A
    379A
  INPUT

  sig { void }
  def test_part1
    assert_equal 126_384, described_class.new(input).part1
  end
end
