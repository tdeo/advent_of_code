# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/06_tuning_trouble')

class TuningTroubleTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(TuningTrouble)) }
  def described_class = TuningTrouble

  sig { void }
  def test_part1
    assert_equal 5, described_class.new('bvwbjplbgvbhsrlpgdmjqwftvncz').part1
    assert_equal 6, described_class.new('nppdvjthqldpwncqszvftbrmjlhg').part1
    assert_equal 10, described_class.new('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg').part1
    assert_equal 11, described_class.new('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw').part1
  end

  sig { void }
  def test_part2
    assert_equal 19, described_class.new('mjqjpqmgbljsphdztnvjfqwrcgsmlb').part2
    assert_equal 23, described_class.new('bvwbjplbgvbhsrlpgdmjqwftvncz').part2
    assert_equal 23, described_class.new('nppdvjthqldpwncqszvftbrmjlhg').part2
    assert_equal 29, described_class.new('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg').part2
    assert_equal 26, described_class.new('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw').part2
  end
end
