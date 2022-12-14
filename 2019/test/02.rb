# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_program_alarm')

describe ProgramAlarm do
  before { @k = ProgramAlarm }

  def test_part1
    assert_equal 3500, @k.new('1,9,10,3,2,3,11,0,99,30,40,50').part1(test: true)

    assert_equal 30, @k.new('1,1,1,4,99,5,6,0,99').part1(test: true)
  end

  def test_part2
    i = @k.new('1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,6,23,2,13,23,27,1,27,13,31,1,9,31,35,1,35,9,39,1,39,5,43,2,6,43,47,1,47,6,51,2,51,9,55,2,55,13,59,1,59,6,63,1,10,63,67,2,67,9,71,2,6,71,75,1,75,5,79,2,79,10,83,1,5,83,87,2,9,87,91,1,5,91,95,2,13,95,99,1,99,10,103,1,103,2,107,1,107,6,0,99,2,14,0,0')

    assert_equal 1202, i.part2(2_842_648)
  end
end
