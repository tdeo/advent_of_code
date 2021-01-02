# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_custom_customs')

describe CustomCustoms do
  before { @k = CustomCustoms }

  def test_part1
    assert_equal 11, @k.new('abc

a
b
c

ab
ac

a
a
a
a

b').part1
  end

  def test_part2
    assert_equal 6, @k.new('abc

a
b
c

ab
ac

a
a
a
a

b').part2
  end
end
