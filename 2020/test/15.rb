require 'minitest/autorun'
require_relative('../lib/15_rambunctious_recitation.rb')

describe RambunctiousRecitation do
  before { @k = RambunctiousRecitation }

  def test_part1
    assert_equal 436, @k.new('0,3,6').part1
  end
end
