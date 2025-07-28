# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_immune_system_simulator_xx')

class ImmuneSystemSimulatorXxTest < Minitest::Test
  def described_class = ImmuneSystemSimulatorXx

  def test_part1
    assert_equal 5216, described_class.new(<<~INPUT).part1
      Immune System:
      17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
      989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

      Infection:
      801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
      4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4
    INPUT
  end

  def test_part2
    assert_equal 51, described_class.new(<<~INPUT).part2
      Immune System:
      17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
      989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

      Infection:
      801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
      4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4
    INPUT
  end
end
