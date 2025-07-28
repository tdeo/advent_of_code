# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_encoding_error')

class EncodingErrorTest < Minitest::Test
  def described_class = EncodingError

  def test_part1
    assert_equal 127, described_class.new('35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576').part1(5)
  end

  def test_part2
    assert_equal 62, described_class.new('35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576').part2(5)
  end
end
