# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_promenade')

class PromenadeTest < Minitest::Test
  def described_class = Promenade

  def test_part1
    assert_equal 'baedc', described_class.new('s1,x3/4,pe/b', 5).part1
  end
end
