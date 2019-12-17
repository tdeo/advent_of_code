require 'minitest/autorun'
require_relative('../lib/17_setand_forget.rb')

describe SetandForget do
  before { @k = SetandForget }

  def xtest_part1
    assert_equal nil, @k.new('input').part1
  end

  def xtest_part2
    assert_equal nil, @k.new('input').part2
  end
end
