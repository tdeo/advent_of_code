require 'minitest/autorun'
require_relative('../lib/16_promenade.rb')

describe Promenade do
  before { @k = Promenade }

  def test_part1
    assert_equal 'baedc', @k.new('s1,x3/4,pe/b', 5).part1
  end
end
