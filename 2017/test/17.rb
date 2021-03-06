# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_spinlock')

describe Spinlock do
  before { @k = Spinlock }

  def test_part1
    assert_equal 638, @k.new(3).part1
  end
end
