# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/20_pulse_propagation')

class PulsePropagationTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(PulsePropagation)) }
  def described_class = PulsePropagation

  sig { returns(String) }
  def input = <<~INPUT
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
  INPUT

  sig { void }
  def test_part1
    assert_equal 32_000_000, described_class.new(input).part1
  end

  sig { void }
  def test_part1_2
    assert_equal 11_687_500, described_class.new(<<~INPUT).part1
      broadcaster -> a
      %a -> inv, con
      &inv -> b
      %b -> con
      &con -> output
    INPUT
  end
end
