# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/07_no_space_left_on_device')

class NoSpaceLeftOnDeviceTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(NoSpaceLeftOnDevice)) }
  def described_class = NoSpaceLeftOnDevice

  sig { returns(String) }
  def input = <<~INPUT
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
  INPUT

  sig { void }
  def test_part1
    assert_equal 95_437, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 24_933_642, described_class.new(input).part2
  end
end
