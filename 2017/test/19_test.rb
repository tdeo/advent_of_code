# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/19_tubes')

class TubesTest < Minitest::Test
  def described_class = Tubes

  def test_part1
    assert_equal 'ABCDEF', described_class.new('     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
').part1
  end

  def test_part2
    assert_equal 38, described_class.new('     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
').part2
  end
end
