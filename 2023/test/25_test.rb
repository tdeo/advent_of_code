# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/25_snowverload')

class SnowverloadTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(Snowverload)) }
  def described_class = Snowverload

  sig { returns(String) }
  def input = <<~INPUT
    jqt: rhn xhk nvd
    rsh: frs pzl lsr
    xhk: hfx
    cmg: qnr nvd lhk bvb
    rhn: xhk bvb hfx
    bvb: xhk hfx
    pzl: lsr hfx nvd
    qnr: nvd
    ntq: jqt hfx bvb xhk
    nvd: lhk
    lsr: lhk
    rzs: qnr cmg lsr rsh
    frs: qnr lhk lsr
  INPUT

  sig { void }
  def test_part1
    assert_equal 54, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 0, described_class.new(input).part2
  end
end
