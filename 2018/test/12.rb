require 'minitest/autorun'
require_relative('../lib/12_subterranean_sustainability.rb')

describe SubterraneanSustainability do
  before { @k = SubterraneanSustainability }

  def test_part1
    assert_equal 325, @k.new('initial state: #..#.#..##......###...###

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
