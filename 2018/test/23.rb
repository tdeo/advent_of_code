require 'minitest/autorun'
require_relative('../lib/23_experimental_emergency_teleportation.rb')

describe ExperimentalEmergencyTeleportation do
  before { @k = ExperimentalEmergencyTeleportation }

  def test_part1
    assert_equal 7, @k.new('pos=<0,0,0>, r=4
pos=<1,0,0>, r=1
pos=<4,0,0>, r=3
pos=<0,2,0>, r=1
pos=<0,5,0>, r=3
pos=<0,0,3>, r=1
pos=<1,1,1>, r=1
pos=<1,1,2>, r=1
pos=<1,3,1>, r=1').part1
  end

  def test_part2
    assert_equal 36, @k.new('pos=<10,12,12>, r=2
pos=<12,14,12>, r=2
pos=<16,12,12>, r=4
pos=<14,14,14>, r=6
pos=<50,50,50>, r=200
pos=<10,10,10>, r=5').part2
  end
end
