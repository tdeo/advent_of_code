# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/08_authentication')

describe Authentication do
  before { @k = Authentication }

  def test_part1
    assert_equal 6, @k.new('rect 3x2
      rotate column x=1 by 1
      rotate row y=0 by 4
      rotate column x=1 by 1', 3, 7,).part1
  end
end
