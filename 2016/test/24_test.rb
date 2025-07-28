# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_air_duct')

class AirDuctTest < Minitest::Test
  def described_class = AirDuct

  def test_part1
    assert_equal 14, described_class.new('###########
#0.1.....2#
#.#######.#
#4.......3#
###########').part1
  end
end
