# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_flawed_frequency_transmission')

class FlawedFrequencyTransmissionTest < Minitest::Test
  def described_class = FlawedFrequencyTransmission

  def test_part1
    assert_equal '48226158', described_class.new('12345678').part1(1)
    assert_equal '34040438', described_class.new('12345678').part1(2)
    assert_equal '03415518', described_class.new('12345678').part1(3)
    assert_equal '01029498', described_class.new('12345678').part1(4)

    assert_equal '24176176', described_class.new('80871224585914546619083218645595').part1
    assert_equal '73745418', described_class.new('19617804207202209144916044189917').part1
    assert_equal '52432133', described_class.new('69317163492948606335995924319873').part1
  end

  def test_part2
    assert_equal '84462026', described_class.new('03036732577212944063491565474664').part2
    assert_equal '78725270', described_class.new('02935109699940807407585447034323').part2
    assert_equal '53553731', described_class.new('03081770884921959731165446850517').part2
  end
end
