# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/03_mull_it_over')

class MullItOverTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(MullItOver)) }
  def described_class = MullItOver

  sig { returns(String) }
  def input = <<~INPUT
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  INPUT

  sig { void }
  def test_part1
    assert_equal 161, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 48, described_class.new(<<~INPUT).part2
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    INPUT
  end
end
