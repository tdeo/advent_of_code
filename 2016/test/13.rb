require 'minitest/autorun'
require_relative('../lib/13_cubicles.rb')

describe Cubicles do
  before { @k = Cubicles }

  def test_demo
    assert_equal 11, @k.new('10').demo
  end
end

