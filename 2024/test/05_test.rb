# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/05_print_queue')

class PrintQueueTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(PrintQueue)) }
  def described_class = PrintQueue

  sig { returns(String) }
  def input = <<~INPUT
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
  INPUT

  sig { void }
  def test_part1
    assert_equal 143, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 123, described_class.new(input).part2
  end
end
