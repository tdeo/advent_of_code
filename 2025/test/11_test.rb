# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/11_reactor')

class ReactorTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Reactor)) }
  def described_class = Reactor

  sig { returns(String) }
  def input = <<~INPUT
    aaa: you hhh
    you: bbb ccc
    bbb: ddd eee
    ccc: ddd eee fff
    ddd: ggg
    eee: out
    fff: out
    ggg: out
    hhh: ccc fff iii
    iii: out
  INPUT

  sig { returns(String) }
  def input2 = <<~INPUT
    svr: aaa bbb
    aaa: fft
    fft: ccc
    bbb: tty
    tty: ccc
    ccc: ddd eee
    ddd: hub
    hub: fff
    eee: dac
    dac: fff
    fff: ggg hhh
    ggg: out
    hhh: out
  INPUT

  sig { void }
  def test_part1
    assert_equal 5, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2, described_class.new(input2).part2
  end
end
