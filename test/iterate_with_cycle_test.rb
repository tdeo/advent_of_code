# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/iterate_with_cycle'

describe IterateWithCycle do
  before { @k = IterateWithCycle }

  def test_with_no_cycle
    i = @k.new(0) { |x| x + 1 }

    assert_equal 12, i.iterate(12)
  end

  def test_with_cycle
    i = @k.new(0) { |x| (x + 1) % 10 }

    assert_equal 2, i.iterate((10**30) + 2)
  end
end
