# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/13_mine_cart_madness')

class MineCartMadnessTest < Minitest::Test
  def described_class = MineCartMadness

  def test_part1
    assert_equal '7,3', described_class.new([
      # Using # instead of \ so it doesn't escape stuff
      '/->-#        ',
      '|   |  /----#',
      '| /-+--+-#  |',
      '| | |  | v  |',
      '#-+-/  #-+--/',
      '  #------/   ',
    ].join("\n").tr('#', '\\')).part1
  end

  def test_part2
    assert_equal '6,4', described_class.new([
      # Using # instead of \ so it doesn't escape stuff
      '/>-<#',
      '|   |',
      '| /<+-#',
      '| | | v',
      '#>+</ |',
      '  |   ^',
      '  #<->/',
    ].join("\n").tr('#', '\\')).part2
  end
end
