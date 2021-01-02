# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_corporate_policy')

describe CorporatePolicy do
  before { @k = CorporatePolicy }

  def test_part1
    assert_equal 'abcdffaa', @k.new('abcdefgh').part1
    assert_equal 'ghjaabcc', @k.new('ghijklmn').part1
  end
end
