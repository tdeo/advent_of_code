# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/09_disk_fragmenter')

class DiskFragmenterTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(DiskFragmenter)) }
  def described_class = DiskFragmenter

  sig { returns(String) }
  def input = <<~INPUT
    2333133121414131402
  INPUT

  sig { void }
  def test_part1
    assert_equal 1928, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2858, described_class.new(input).part2
  end
end
