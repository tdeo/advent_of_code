# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/25_let_it_snow')

class LetItSnowTest < Minitest::Test
  def described_class = LetItSnow

  def test_part1
    assert_equal 10_600_672, described_class.new('To continue, please consult the code grid in the manual.  Enter the code at row 4, column 5.').part1
  end
end
