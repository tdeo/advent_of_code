require 'minitest/autorun'
require_relative('../lib/21_fractal.rb')

describe Fractal do
  before { @k = Fractal }

  def test_part1
    assert_equal 12, @k.new('../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#', 2).part1
  end
end
