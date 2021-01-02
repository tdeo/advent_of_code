# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_universal_orbit_map')

describe UniversalOrbitMap do
  before { @k = UniversalOrbitMap }

  def test_part1
    assert_equal 42, @k.new('COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
').part1
  end

  def test_part2
    assert_equal 4, @k.new('COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN').part2
  end
end
