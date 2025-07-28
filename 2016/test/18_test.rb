# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_like_a_rogue')

class LikeARogueTest < Minitest::Test
  def described_class = LikeARogue

  def test_part1
    assert_equal 38, described_class.new('.^^.^.^^^^').part1(10)
  end

  # def test_part2
  #   assert_equal answer, described_class.new(input).part2
  # end
end
