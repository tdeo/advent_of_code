# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/09_movie_theater')

class MovieTheaterTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(MovieTheater)) }
  def described_class = MovieTheater

  sig { returns(String) }
  def input = <<~INPUT
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
  INPUT

  sig { void }
  def test_part1
    assert_equal 50, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 24, described_class.new(input).part2
  end
end
