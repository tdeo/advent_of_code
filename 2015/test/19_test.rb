# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/19_medicine_for_rudolph')

class MedicineForRudolphTest < Minitest::Test
  def described_class = MedicineForRudolph

  def test_part1
    assert_equal 4, described_class.new('H => HO
H => OH
O => HH

HOH').part1
  end

  def test_part2
    assert_equal 3, described_class.new('e => H
e => O
H => HO
H => OH
O => HH

HOH').part2
    assert_equal 6, described_class.new('e => H
e => O
H => HO
H => OH
O => HH

HOHOHO').part2
  end
end
