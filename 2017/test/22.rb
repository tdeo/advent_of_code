# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_sporifica_virus')

describe SporificaVirus do
  before { @k = SporificaVirus }

  def test_part1
    assert_equal 5587, @k.new('..#
#..
...').part1
  end

  def test_part2
    assert_equal 2_511_944, @k.new('..#
#..
...').part2
  end
end
