# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_sensor_boost')

describe SensorBoost do
  before { @k = SensorBoost }

  def test_part1
    assert_operator(@k.new('1102,34915192,34915192,7,4,7,99,0').part1, :>, 10**15)

    assert_equal 1_125_899_906_842_624, @k.new('104,1125899906842624,99').part1
  end
end
