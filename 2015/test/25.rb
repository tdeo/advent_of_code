require 'minitest/autorun'
require_relative('../lib/25_let_it_snow.rb')

describe LetItSnow do
  before { @k = LetItSnow }

  def test_part1
    assert_equal 10600672, @k.new('To continue, please consult the code grid in the manual.  Enter the code at row 4, column 5.').part1
  end
end
