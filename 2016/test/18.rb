# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_like_a_rogue')

describe LikeARogue do
  before { @k = LikeARogue }

  def test_part1
    assert_equal 38, @k.new('.^^.^.^^^^').part1(10)
  end

  # def test_part2
  #   assert_equal answer, @k.new(input).part2
  # end
end
