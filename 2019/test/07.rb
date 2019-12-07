require 'minitest/autorun'
require_relative('../lib/07_amplification_circuit.rb')

describe AmplificationCircuit do
  before { @k = AmplificationCircuit }

  def test_part1
    assert_equal 43210, @k.new('3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0').part1
  end

  def test_part2
    assert_equal 139629729, @k.new('3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5').part2
  end
end
