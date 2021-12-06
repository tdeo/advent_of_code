require 'minitest/autorun'
require_relative('../lib/03_binary_diagnostic')

describe BinaryDiagnostic do
  before { @k = BinaryDiagnostic }

  def test_part1
    assert_equal 198, @k.new(<<~INPUT).part1
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  end

  def test_part2
    assert_equal 230, @k.new(<<~INPUT).part2
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  end
end
