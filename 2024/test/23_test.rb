# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/23_lan_party')

class LanPartyTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(LanParty)) }
  def described_class = LanParty

  sig { returns(String) }
  def input = <<~INPUT
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
  INPUT

  sig { void }
  def test_part1
    assert_equal 7, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 'co,de,ka,ta', described_class.new(input).part2
  end
end
