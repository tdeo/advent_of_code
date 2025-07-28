# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/06_memory'

class MemoryTest < Minitest::Test
  def test_part1
    assert_equal 5, Memory.new('0 2 7 0').part1
  end

  def test_part2
    assert_equal 4, Memory.new('0 2 7 0').part2
  end
end
