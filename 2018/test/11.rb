require 'minitest/autorun'
require_relative('../lib/11_chronal_charge.rb')

describe ChronalCharge do
  before { @k = ChronalCharge }

  def test_part1
    assert_equal '33,45', @k.new('18').part1
  end

  def test_part1_2
    assert_equal '21,61', @k.new('42').part1
  end

  def test_part2
    assert_equal '90,269,16', @k.new('18').part2
  end

  def test_part2_2
    assert_equal '232,251,12', @k.new('42').part2
  end
end
