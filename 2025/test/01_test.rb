# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/01_secret_entrance')

class SecretEntranceTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(SecretEntrance)) }
  def described_class = SecretEntrance

  sig { returns(String) }
  def input = <<~INPUT
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
  INPUT

  sig { void }
  def test_part1
    assert_equal 3, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 6, described_class.new(input).part2
  end
end
