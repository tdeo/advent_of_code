# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_corporate_policy')

class CorporatePolicyTest < Minitest::Test
  def described_class = CorporatePolicy

  def test_part1
    assert_equal 'abcdffaa', described_class.new('abcdefgh').part1
    assert_equal 'ghjaabcc', described_class.new('ghijklmn').part1
  end
end
