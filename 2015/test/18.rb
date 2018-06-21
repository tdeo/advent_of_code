require 'minitest/autorun'
require_relative('../lib/18_like_a_gif.rb')

describe LikeAGif do
  before { @k = LikeAGif }

  def test_part1
    assert_equal 4, @k.new(".#.#.#\n..##.\n#....#\n..#...\n#.#..#\n####..").part1(4)
  end

  def test_part2
    assert_equal 17, @k.new(".#.#.#\n..##.\n#....#\n..#...\n#.#..#\n####..").part2(5)
  end
end
