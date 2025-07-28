# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/08_space_image_format')

class SpaceImageFormatTest < Minitest::Test
  def described_class = SpaceImageFormat

  def test_part1
    assert_equal 1, described_class.new('123456789012').part1(2, 3)
  end

  def test_part2
    assert_equal " #\n# ", described_class.new('0222112222120000').part2(2, 2)
  end
end
