require 'minitest/autorun'
require_relative('../lib/01_not_quite_lisp.rb')

describe NotQuiteLisp do
  before { @k = NotQuiteLisp }

  def test_part1
    assert_equal 0, @k.new('(())').part1
    assert_equal 0, @k.new('()()').part1
    assert_equal 3, @k.new('(((').part1
    assert_equal 3, @k.new('(()(()(').part1
    assert_equal 3, @k.new('))(((((').part1
    assert_equal(-1, @k.new('())').part1)
    assert_equal(-1, @k.new('))(').part1)
  end

  def test_part2
    assert_equal 1, @k.new(')').part2
    assert_equal 5, @k.new('()())').part2
  end
end
