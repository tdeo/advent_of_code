require 'minitest/autorun'
require_relative('../lib/11_space_police.rb')

describe SpacePolice do
  before { @k = SpacePolice }

  def xtest_part1
    assert_equal nil, @k.new('input').part1
  end

  def xtest_part2
    assert_equal nil, @k.new('input').part2
  end
end
