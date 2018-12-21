require 'minitest/autorun'
require_relative('../lib/19_go_with_the_flow.rb')

describe GoWithTheFlow do
  before { @k = GoWithTheFlow }

  def test_part1
    assert_equal 6, @k.new('#ip 0
seti 5 0 1
seti 6 0 2
addi 0 1 0
addr 1 2 3
setr 1 0 0
seti 8 0 4
seti 9 0 5').part1
  end
end
