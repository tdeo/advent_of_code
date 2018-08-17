require 'minitest/autorun'
require_relative('../lib/25_let_it_snow.rb')

describe LetItSnow do
  before { @k = LetItSnow }

  def test_part1
    assert_equal 10600672, @k.new('').part1(4, 5)
  end
end
