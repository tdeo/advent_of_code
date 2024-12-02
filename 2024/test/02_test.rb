# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/02_red_nosed_reports')

class RedNosedReportsTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RedNosedReports)) }
  def described_class = RedNosedReports

  sig { returns(String) }
  def input = <<~INPUT
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
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
