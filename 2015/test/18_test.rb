# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_like_a_gif')

class LikeAGifTest < Minitest::Test
  def described_class = LikeAGif

  def test_part1
    assert_equal 4, described_class.new(".#.#.#\n..##.\n#....#\n..#...\n#.#..#\n####..").part1(4)
  end

  def test_part2
    assert_equal 17, described_class.new(".#.#.#\n..##.\n#....#\n..#...\n#.#..#\n####..").part2(5)
  end
end
