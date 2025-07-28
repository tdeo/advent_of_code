# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_subterranean_sustainability')

class SubterraneanSustainabilityTest < Minitest::Test
  def described_class = SubterraneanSustainability

  def test_part1
    assert_equal 325, described_class.new('initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #').part1
  end
end
