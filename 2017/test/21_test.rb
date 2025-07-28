# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/21_fractal')

class FractalTest < Minitest::Test
  def described_class = Fractal

  def test_part1
    assert_equal 12, described_class.new('../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#', 2,).part1
  end
end
