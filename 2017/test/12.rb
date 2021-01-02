# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_plumber')

describe Plumber do
  before { @k = Plumber }

  def test_part1
    assert_equal 6, @k.new('0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
').part1
  end

  def test_part2
    assert_equal 2, @k.new('0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
').part2
  end
end
