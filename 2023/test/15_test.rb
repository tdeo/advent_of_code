# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/15_lens_library')

class LensLibraryTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(LensLibrary)) }
  def described_class = LensLibrary

  sig { returns(String) }
  def input = <<~INPUT
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
  INPUT

  sig { void }
  def test_hash
    assert_equal 200, described_class.new('H').hash('H')
    assert_equal 52, described_class.new('HASH').hash('HASH')
    assert_equal 231, described_class.new('ot=7').hash('ot=7')
  end

  sig { void }
  def test_part1
    assert_equal 1320, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 145, described_class.new(input).part2
  end
end
