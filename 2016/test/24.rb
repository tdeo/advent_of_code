# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_air_duct')

describe AirDuct do
  before { @k = AirDuct }

  def test_part1
    assert_equal 14, @k.new('###########
#0.1.....2#
#.#######.#
#4.......3#
###########').part1
  end
end
