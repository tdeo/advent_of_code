# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_trick_shot')

describe TrickShot do
  let(:described_class) { TrickShot }
  let(:input) { <<~INPUT }
    target area: x=20..30, y=-10..-5
  INPUT

  def test_part1
    assert_equal 45, described_class.new(input).part1
  end

  def test_part2
    assert_equal 112, described_class.new(input).part2
  end
end
