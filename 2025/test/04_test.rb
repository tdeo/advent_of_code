# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/04_printing_department')

class PrintingDepartmentTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(PrintingDepartment)) }
  def described_class = PrintingDepartment

  sig { returns(String) }
  def input = <<~INPUT
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
  INPUT

  sig { void }
  def test_part1
    assert_equal 13, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 43, described_class.new(input).part2
  end
end
