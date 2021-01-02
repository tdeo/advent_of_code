# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_no_matter_how_you_slice_it')

describe NoMatterHowYouSliceIt do
  before { @k = NoMatterHowYouSliceIt }

  def test_part1
    assert_equal 4, @k.new('#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2').part1
  end

  def test_part2
    assert_equal 3, @k.new('#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2').part2
  end
end
