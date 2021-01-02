# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/19_tubes')

describe Tubes do
  before { @k = Tubes }

  def test_part1
    assert_equal 'ABCDEF', @k.new('     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
').part1
  end

  def test_part2
    assert_equal 38, @k.new('     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
').part2
  end
end
