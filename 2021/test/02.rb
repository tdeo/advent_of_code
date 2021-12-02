# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_dive')

describe Dive do
  before { @k = Dive }

  def test_part1
    assert_equal 150, @k.new(<<~INPUT).part1
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    INPUT
  end

  def test_part2
    assert_equal 900, @k.new(<<~INPUT).part2
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    INPUT
  end
end
