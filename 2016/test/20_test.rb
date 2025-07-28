# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/20_firewall_rules')

class FirewallRulesTest < Minitest::Test
  def described_class = FirewallRules

  def test_part1
    assert_equal 3, described_class.new('5-8
0-2
4-7').part1
  end

  def test_part2
    assert_equal (2**32) - 8, described_class.new('5-8
0-2
4-7').part2
  end
end
