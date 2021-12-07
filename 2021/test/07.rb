# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/07_the_treacheryof_whales')

describe TheTreacheryofWhales do
  before { @k = TheTreacheryofWhales }

  def test_part1
    assert_equal 37, @k.new(<<~INPUT).part1
      16,1,2,0,4,2,7,1,2,14
    INPUT
  end

  def test_part2
    assert_equal 168, @k.new(<<~INPUT).part2
      16,1,2,0,4,2,7,1,2,14
    INPUT
  end
end
