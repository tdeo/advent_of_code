# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/20_swarn')

class SwarnTest < Minitest::Test
  def described_class = Swarn

  def test_part1
    assert_equal 0, described_class.new('p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
p=<4,0,0>, v=<0,0,0>, a=<-2,0,0>').part1
  end

  def test_part2
    assert_equal 2, described_class.new('p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
p=<4,0,0>, v=<0,0,0>, a=<-2,0,0>').part2
  end
end
