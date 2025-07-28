# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_sporifica_virus')

class SporificaVirusTest < Minitest::Test
  def described_class = SporificaVirus

  def test_part1
    assert_equal 5587, described_class.new('..#
#..
...').part1
  end

  def test_part2
    slow_test!

    assert_equal 2_511_944, described_class.new('..#
#..
...').part2
  end
end
