# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/03_rucksack_reorganization')

class RucksackReorganizationTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(RucksackReorganization)) }
  def described_class = RucksackReorganization

  sig { returns(String) }
  def input = <<~INPUT
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
  INPUT

  sig { void }
  def test_part1
    assert_equal 157, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 70, described_class.new(input).part2
  end
end
