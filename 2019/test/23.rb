require 'minitest/autorun'
require_relative('../lib/23_category_six.rb')

describe CategorySix do
  before { @k = CategorySix }

  def test_part1
    assert_equal 256, @k.new('3,60,1005,60,18,1101,0,1,61,4,61,104,1011,104,1,1105,1,22,1101,0,0,61,3,62,1007,62,0,64,1005,64,22,3,63,1002,63,2,63,1007,63,256,65,1005,65,48,1101,0,255,61,4,61,4,62,4,63,1105,1,22,99').part1(2)
  end
end
