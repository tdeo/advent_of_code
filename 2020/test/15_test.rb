# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_rambunctious_recitation')

class RambunctiousRecitationTest < Minitest::Test
  def described_class = RambunctiousRecitation

  def test_part1
    assert_equal 436, described_class.new('0,3,6').part1
  end
end
