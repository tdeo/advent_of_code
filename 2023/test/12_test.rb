# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/12_hot_springs')

class HotSpringsTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(HotSprings)) }
  def described_class = HotSprings

  sig { returns(String) }
  def input = <<~INPUT
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
  INPUT

  sig { void }
  def test_part1
    assert_equal 21, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 525_152, described_class.new(input).part2
  end
end
