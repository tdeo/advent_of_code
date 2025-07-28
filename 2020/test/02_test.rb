# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_password_philosophy')

class PasswordPhilosophyTest < Minitest::Test
  def described_class = PasswordPhilosophy

  def test_part1
    assert_equal 2, described_class.new('1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc').part1
  end

  def test_part2
    assert_equal 1, described_class.new('1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc').part2
  end
end
