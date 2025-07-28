# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/04_camp_cleanup')

class CampCleanupTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(CampCleanup)) }
  def described_class = CampCleanup

  sig { returns(String) }
  def input = <<~INPUT
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
  INPUT

  sig { void }
  def test_part1
    assert_equal 2, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 4, described_class.new(input).part2
  end
end
