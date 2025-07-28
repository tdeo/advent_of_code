# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_duet')

class DuetTest < Minitest::Test
  def described_class = Duet

  def test_part1
    assert_equal 4, described_class.new('set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2').part1
  end

  def test_part2
    assert_equal 3, described_class.new('snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d').part2
  end
end
