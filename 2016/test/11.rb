require 'minitest/autorun'
require_relative('../lib/11_thermoelectric_generators.rb')

describe ThermoelectricGenerators do
  before { @k = ThermoelectricGenerators }

  def test_part1
    assert_equal 11, @k.new('The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
    The second floor contains a hydrogen generator.
    The third floor contains a lithium generator.
    The fourth floor contains nothing relevant.').part1
  end
end

