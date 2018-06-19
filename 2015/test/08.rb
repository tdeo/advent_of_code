require 'minitest/autorun'
require_relative('../lib/08_matchsticks.rb')

describe Matchsticks do
  before { @k = Matchsticks }

  def test_part1
    assert_equal 12, @k.new('""
"abc"
"aaa\"aaa"
"\x27"').part1
  end

  def test_part2
    assert_equal 19, @k.new('""
"abc"
"aaa\"aaa"
"\x27"').part2
  end
end
