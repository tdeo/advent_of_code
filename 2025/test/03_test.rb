# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/03_lobby')

class LobbyTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Lobby)) }
  def described_class = Lobby

  sig { returns(String) }
  def input = <<~INPUT
    987654321111111
    811111111111119
    234234234234278
    818181911112111
  INPUT

  sig { void }
  def test_part1
    assert_equal 357, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 3_121_910_778_619, described_class.new(input).part2
  end
end
