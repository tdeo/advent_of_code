# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_leonardo_monorail')

class LeonardoMonorailTest < Minitest::Test
  def described_class = LeonardoMonorail

  def test_part1
    assert_equal 42, described_class.new('cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a').part1
  end
end
