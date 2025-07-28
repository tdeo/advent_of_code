# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_chronal_charge')

class ChronalChargeTest < Minitest::Test
  def described_class = ChronalCharge

  def test_part1
    assert_equal '33,45', described_class.new('18').part1
  end

  def test_part1_2
    assert_equal '21,61', described_class.new('42').part1
  end

  def test_part2
    assert_equal '90,269,16', described_class.new('18').part2
  end

  def test_part2_2
    assert_equal '232,251,12', described_class.new('42').part2
  end
end
