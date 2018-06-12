require 'minitest/autorun'
require_relative('../lib/11_thermoelectric_generators.rb')

describe ThermoelectricGenerators do
  before { @k = ThermoelectricGenerators }

  def test_demo
    assert_equal 11, @k.new('').demo
  end
end

