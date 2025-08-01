# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_taxicab')

class TaxicabTest < Minitest::Test
  def described_class = Taxicab

  def test_part1_1
    assert_equal 5, described_class.new('R2, L3').part1
  end

  def test_part1_2
    assert_equal 2, described_class.new('R2, R2, R2').part1
  end

  def test_part1_3
    assert_equal 12, described_class.new('R5, L5, R5, R3').part1
  end

  def test_part2
    assert_equal 4, described_class.new('R8, R4, R4, R8').part2
  end
end
