# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_hex')

describe Hex do
  before { @k = Hex }

  def test_part1_1
    assert_equal 3, @k.new('ne,ne,ne').part1
  end

  def test_part1_2
    assert_equal 0, @k.new('ne,ne,sw,sw').part1
  end

  def test_part1_3
    assert_equal 2, @k.new('ne,ne,s,s').part1
  end

  def test_part1_4
    assert_equal 3, @k.new('se,sw,se,sw,sw').part1
  end
end
