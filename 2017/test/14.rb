require 'minitest/autorun'
require_relative('../lib/14_defrag.rb')

describe Defrag do
  before { @k = Defrag }

  def test_part1
    assert_equal 8108, @k.new('flqrgnkx').part1
  end

  def test_part2
    assert_equal 1242, @k.new('flqrgnkx').part2
  end
end
