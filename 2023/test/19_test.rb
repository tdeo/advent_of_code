# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/19_aplenty')

class AplentyTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Aplenty)) }
  def described_class = Aplenty

  sig { returns(String) }
  def input = <<~INPUT
    px{a<2006:qkq,m>2090:A,rfg}
    pv{a>1716:R,A}
    lnx{m>1548:A,A}
    rfg{s<537:gd,x>2440:R,A}
    qs{s>3448:A,lnx}
    qkq{x<1416:A,crn}
    crn{x>2662:A,R}
    in{s<1351:px,qqz}
    qqz{s>2770:qs,m<1801:hdj,R}
    gd{a>3333:R,R}
    hdj{m>838:A,pv}

    {x=787,m=2655,a=1222,s=2876}
    {x=1679,m=44,a=2067,s=496}
    {x=2036,m=264,a=79,s=2244}
    {x=2461,m=1339,a=466,s=291}
    {x=2127,m=1623,a=2188,s=1013}
  INPUT

  sig { void }
  def test_part1
    assert_equal 19_114, described_class.new(input).part1
  end

  sig { void }
  def test_part2_1
    assert_equal 4000**4, described_class.new(input).part2('lnx')
  end

  sig { void }
  def test_part2_2
    assert_equal 0, described_class.new(input).part2('gd')
  end

  sig { void }
  def test_part2_3
    assert_equal (4000 - 2662) * (4000**3), described_class.new(input).part2('crn')
  end

  sig { void }
  def test_part2_4
    assert_equal (4000 - 2662 + 1415) * (4000**3), described_class.new(input).part2('qkq')
  end

  sig { void }
  def test_part2_5
    assert_equal 1716 * (4000**3), described_class.new(input).part2('pv')
  end

  sig { void }
  def test_part2_6
    assert_equal ((4000 - 839 + 1) * (4000**3)) + (838 * 1716 * (4000**2)), described_class.new(input).part2('hdj')
  end

  sig { void }
  def test_part2
    assert_equal 167_409_079_868_000, described_class.new(input).part2('in')
  end
end
