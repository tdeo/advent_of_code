require 'minitest/autorun'
require_relative('../lib/08_registers.rb')

describe Registers do
  before { @k = Registers }

  def test_part1
    assert_equal 1, @k.new('b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10').part1
  end

  def test_part2
    assert_equal 10, @k.new('b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10').part2
  end
end
