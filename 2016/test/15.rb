require 'minitest/autorun'
require_relative('../lib/15_timing.rb')

describe Timing do
  before { @k = Timing }

  def test_demo
    assert_equal 5, @k.new('').demo
  end
end

