# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_sonar_sweep')

describe SonarSweep do
  before { @k = SonarSweep }

  def test_part1
    assert_equal 7, @k.new(<<~INPUT).part1
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    INPUT
  end

  def test_part2
    assert_equal 5, @k.new(<<~INPUT).part2
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    INPUT
  end
end
