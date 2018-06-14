require 'minitest/autorun'
require_relative('../lib/21_scrambled_letters_and_hash.rb')

describe ScrambledLettersAndHash do
  before { @k = ScrambledLettersAndHash }

  def test_part1
    assert_equal 'decab', @k.new('swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d').part1('abcde')
  end

  def test_part2
    assert_equal 'abcde', @k.new('swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d').part2('decab')
  end
end
