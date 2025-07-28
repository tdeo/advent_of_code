# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/10_hoof_it')

class HoofItTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(HoofIt)) }
  def described_class = HoofIt

  sig { returns(String) }
  def input = <<~INPUT
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
  INPUT

  sig { void }
  def test_part1
    assert_equal 36, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 81, described_class.new(input).part2
  end
end
