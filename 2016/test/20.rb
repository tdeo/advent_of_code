require 'minitest/autorun'
require_relative('../lib/20_firewall_rules.rb')

describe FirewallRules do
  before { @k = FirewallRules }

  def test_part1
    assert_equal 3, @k.new('5-8
0-2
4-7').part1
  end

  def test_part2
    assert_equal 2**32 - 8, @k.new('5-8
0-2
4-7').part2
  end
end
