# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/07_the_sumof_its_parts')

describe TheSumofItsParts do
  before { @k = TheSumofItsParts }

  def test_part1
    assert_equal 'CABDFE', @k.new('Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.').part1
  end

  def test_part2
    assert_equal 15, @k.new('Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.').part2(time: 0, workers: 2)
  end
end
