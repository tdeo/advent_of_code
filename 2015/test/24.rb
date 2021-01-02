# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_balance')

describe Balance do
  before { @k = Balance }

  def test_part1
    assert_equal 99, @k.new("1\n2\n3\n4\n5\n7\n8\n9\n10\n11").part1
  end

  def test_part2
    assert_equal 44, @k.new("1\n2\n3\n4\n5\n7\n8\n9\n10\n11").part2
  end
end
