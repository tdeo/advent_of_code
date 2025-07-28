# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/07_some_assembly_required')

class SomeAssemblyRequiredTest < Minitest::Test
  def described_class = SomeAssemblyRequired

  def test_part1
    i = described_class.new('123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i')
    i.part1

    assert_equal({
                   'd' => 72,
                   'e' => 507,
                   'f' => 492,
                   'g' => 114,
                   'h' => 65_412,
                   'i' => 65_079,
                   'x' => 123,
                   'y' => 456,
                 },
                 i.instance_variable_get(:@gates),)
  end
end
