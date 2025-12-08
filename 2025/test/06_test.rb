# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/06_trash_compactor')

class TrashCompactorTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(TrashCompactor)) }
  def described_class = TrashCompactor

  sig { returns(String) }
  def input = <<~INPUT
    123 328  51 64#{' '}
     45 64  387 23#{' '}
      6 98  215 314
    *   +   *   +#{'  '}
  INPUT

  sig { void }
  def test_part1
    assert_equal 4_277_556, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 3_263_827, described_class.new(input).part2
  end
end
