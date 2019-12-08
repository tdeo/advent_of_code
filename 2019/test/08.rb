require 'minitest/autorun'
require_relative('../lib/08_space_image_format.rb')

describe SpaceImageFormat do
  before { @k = SpaceImageFormat }

  def test_part1
    assert_equal 1, @k.new('123456789012').part1(2, 3)
  end

  def test_part2
    assert_equal " #\n# ", @k.new('0222112222120000').part2(2, 2)
  end
end
