# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_packet_decoder')

describe PacketDecoder do
  let(:described_class) { PacketDecoder }
  let(:input) { '' }

  def test_part1
    assert_equal 16, described_class.new('8A004A801A8002F478').part1
  end

  def test_part1_2
    assert_equal 12, described_class.new('620080001611562C8802118E34').part1
  end

  def test_part1_3
    assert_equal 23, described_class.new('C0015000016115A2E0802F182340').part1
  end

  def test_part1_4
    assert_equal 31, described_class.new('A0016C880162017C3686B18A3D4780').part1
  end

  def test_part2
    assert_equal 3, described_class.new('C200B40A82').part2
  end

  def test_part2_2
    assert_equal 54, described_class.new('04005AC33890').part2
  end

  def test_part2_3
    assert_equal 7, described_class.new('880086C3E88112').part2
  end

  def test_part2_4
    assert_equal 9, described_class.new('CE00C43D881120').part2
  end

  def test_part2_5
    assert_equal 1, described_class.new('D8005AC2A8F0').part2
  end

  def test_part2_6
    assert_equal 0, described_class.new('F600BC2D8F').part2
  end

  def test_part2_7
    assert_equal 0, described_class.new('9C005AC2F8F0').part2
  end

  def test_part2_8
    assert_equal 1, described_class.new('9C0141080250320F1802104A08').part2
  end
end
