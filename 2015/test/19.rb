require 'minitest/autorun'
require_relative('../lib/19_medicine_for_rudolph.rb')

describe MedicineForRudolph do
  before { @k = MedicineForRudolph }

  def test_part1
    assert_equal 4, @k.new('H => HO
H => OH
O => HH

HOH').part1
  end

  def test_part2
    assert_equal 3, @k.new('e => H
e => O
H => HO
H => OH
O => HH

HOH').part2
    assert_equal 6, @k.new('e => H
e => O
H => HO
H => OH
O => HH

HOHOHO').part2
  end
end
