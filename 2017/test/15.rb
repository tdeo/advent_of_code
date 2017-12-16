require 'minitest/autorun'
require_relative('../lib/15_generators.rb')

describe Generators do
  before { @k = Generators }

  def test_part1
    assert_equal 588, @k.new('Gen A 65
      Gen B 8921').part1
  end

  def test_part2
    assert_equal 309, @k.new('Gen A 65
      Gen B 8921').part2
  end
end
