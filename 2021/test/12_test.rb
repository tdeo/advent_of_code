# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/12_passage_pathing')

class PassagePathingTest < Minitest::Test
  def described_class = PassagePathing

  def input = <<~INPUT
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
  INPUT

  def input2 = <<~INPUT
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
  INPUT

  def input3 = <<~INPUT
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
  INPUT

  def test_part1
    assert_equal 10, described_class.new(input).part1
  end

  def test_part1_2
    assert_equal 19, described_class.new(input2).part1
  end

  def test_part1_3
    assert_equal 226, described_class.new(input3).part1
  end

  def test_part2
    assert_equal 36, described_class.new(input).part2
  end

  def test_part2_2
    assert_equal 103, described_class.new(input2).part2
  end

  def test_part2_3
    assert_equal 3509, described_class.new(input3).part2
  end
end
