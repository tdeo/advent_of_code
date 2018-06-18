require 'minitest/autorun'
require_relative('../lib/07_some_assembly_required.rb')

describe SomeAssemblyRequired do
  before { @k = SomeAssemblyRequired }

  def test_part1
    i = @k.new('123 -> x
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
        'h' => 65412,
        'i' => 65079,
        'x' => 123,
        'y' => 456
      },
      i.instance_variable_get(:@gates))
  end

  def test_part2
    assert_equal answer, @k.new(input).part2
  end
end
