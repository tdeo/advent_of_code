# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/25_halting_problem')

describe HaltingProblem do
  before { @k = HaltingProblem }

  def test_part1
    assert_equal 3, @k.new('Begin in state A.
Perform a diagnostic checksum after 6 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.').part1
  end
end
