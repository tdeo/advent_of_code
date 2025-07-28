# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_reindeer_olympics')

class ReindeerOlympicsTest < Minitest::Test
  def described_class = ReindeerOlympics

  def test_part1
    assert_equal 1120, described_class.new('Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.').part1(1000)
  end

  def test_part2
    assert_equal 689, described_class.new('Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.').part2(1000)
  end
end
