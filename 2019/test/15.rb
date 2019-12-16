require 'minitest/autorun'
require_relative('../lib/15_oxygen_system.rb')

describe OxygenSystem do
  before { @k = OxygenSystem }

  def xtest_part1
    assert_equal nil, @k.new('input').part1
  end

  def xtest_part2
    assert_equal nil, @k.new('input').part2
  end
end
