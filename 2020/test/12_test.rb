# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_rain_risk')

class RainRiskTest < Minitest::Test
  def described_class = RainRisk

  def test_part1
    assert_equal 25, described_class.new('F10
N3
F7
R90
F11').part1
  end

  def test_part2
    assert_equal 286, described_class.new('F10
N3
F7
L270
F11').part2
  end
end
