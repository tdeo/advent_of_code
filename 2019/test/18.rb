require 'minitest/autorun'
require_relative('../lib/18_many_worlds_interpretation.rb')

describe ManyWorldsInterpretation do
  before { @k = ManyWorldsInterpretation }

  def test_cycle
    assert_equal false, @k.new('#########
#b.A.@.a#
#########').has_cycle?
    assert_equal true, @k.new('
#####
# @ #
# # #
#   #
#####').has_cycle?
  end

  def test_part2
    assert_equal nil, @k.new('input').part2
  end
end
