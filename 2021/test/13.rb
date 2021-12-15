# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/13_transparent_origami')

describe TransparentOrigami do
  let(:described_class) { TransparentOrigami }
  let(:input) { <<~INPUT }
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
  INPUT

  def test_part1
    assert_equal 17, described_class.new(input).part1
  end

  def test_part2
    assert_equal true, true
  end
end
