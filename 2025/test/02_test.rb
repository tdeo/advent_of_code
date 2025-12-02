# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/02_gift_shop')

class GiftShopTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(GiftShop)) }
  def described_class = GiftShop

  sig { returns(String) }
  def input = <<~INPUT
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
    1698522-1698528,446443-446449,38593856-38593862,565653-565659,
    824824821-824824827,2121212118-2121212124
  INPUT

  sig { void }
  def test_part1
    assert_equal 1_227_775_554, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 4_174_379_265, described_class.new(input).part2
  end
end
