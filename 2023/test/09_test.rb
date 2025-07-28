# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/09_mirage_maintenance')

class MirageMaintenanceTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(MirageMaintenance)) }
  def described_class = MirageMaintenance

  sig { returns(String) }
  def input = <<~INPUT
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
  INPUT

  sig { void }
  def test_part1
    assert_equal 114, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2, described_class.new(input).part2
  end
end
