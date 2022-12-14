# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_wizard_simulator')

describe WizardSimulator do
  before { @k = WizardSimulator }

  def test_part1
    i = @k.new("Hit Points: 13
Damage: 8")
    i.instance_variable_set(:@me, {
                              mana: 250,
                              health: 10,
                              armor: 0,
                            },)

    assert_equal 173 + 53, i.part1
  end
end
