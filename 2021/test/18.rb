# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_snailfish')

describe Snailfish do
  let(:described_class) { Snailfish }
  let(:input) { <<~INPUT }
    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
    [[[5,[2,8]],4],[5,[[9,9],0]]]
    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
    [[[[5,4],[7,7]],8],[[8,3],8]]
    [[9,3],[[9,9],[6,[4,9]]]]
    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
  INPUT

  def test_explode_1
    sn = SnailfishNumber.new '[[[[[9,8],1],2],3],4]'
    sn.explode

    assert_equal '[[[[0,9],2],3],4]', sn.to_s
  end

  def test_explode_2
    sn = SnailfishNumber.new '[7,[6,[5,[4,[3,2]]]]]'
    sn.explode

    assert_equal '[7,[6,[5,[7,0]]]]', sn.to_s
  end

  def test_explode_3
    sn = SnailfishNumber.new '[[6,[5,[4,[3,2]]]],1]'
    sn.explode

    assert_equal '[[6,[5,[7,0]]],3]', sn.to_s
  end

  def test_explode_4
    sn = SnailfishNumber.new '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]'
    sn.explode

    assert_equal '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]', sn.to_s
  end

  def test_explode_5
    sn = SnailfishNumber.new '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]'
    sn.explode

    assert_equal '[[3,[2,[8,0]]],[9,[5,[7,0]]]]', sn.to_s
  end

  def test_split_1
    sn = SnailfishNumber.new '[[[[0,7],4],[15,[0,13]]],[1,1]]'
    sn.split

    assert_equal '[[[[0,7],4],[[7,8],[0,13]]],[1,1]]', sn.to_s
  end

  def test_split_2
    sn = SnailfishNumber.new '[[[[0,7],4],[[7,8],[0,13]]],[1,1]]'
    sn.split

    assert_equal '[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]', sn.to_s
  end

  def test_reduce
    sn = SnailfishNumber.new '[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]'
    sn.reduce

    assert_equal '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]', sn.to_s
  end

  def test_sum_1
    assert_equal '[[[[1,1],[2,2]],[3,3]],[4,4]]', described_class.new(<<~INPUT).final_sum.to_s
      [1,1]
      [2,2]
      [3,3]
      [4,4]
    INPUT
  end

  def test_sum_2
    assert_equal '[[[[3,0],[5,3]],[4,4]],[5,5]]', described_class.new(<<~INPUT).final_sum.to_s
      [1,1]
      [2,2]
      [3,3]
      [4,4]
      [5,5]
    INPUT
  end

  def test_sum_3
    assert_equal '[[[[5,0],[7,4]],[5,5]],[6,6]]', described_class.new(<<~INPUT).final_sum.to_s
      [1,1]
      [2,2]
      [3,3]
      [4,4]
      [5,5]
      [6,6]
    INPUT
  end

  def test_sum_4
    assert_equal '[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]', described_class.new(<<~INPUT).final_sum.to_s
      [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
      [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
      [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
      [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
      [7,[5,[[3,8],[1,4]]]]
      [[2,[2,2]],[8,[8,1]]]
      [2,9]
      [1,[[[9,3],9],[[9,0],[0,7]]]]
      [[[5,[7,4]],7],1]
      [[[[4,2],2],6],[8,7]]
    INPUT
  end

  def test_magnitude_1
    assert_equal 143, SnailfishNumber.new('[[1,2],[[3,4],5]]').magnitude
  end

  def test_magnitude_2
    assert_equal 1384, SnailfishNumber.new('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]').magnitude
  end

  def test_magnitude_3
    assert_equal 445, SnailfishNumber.new('[[[[1,1],[2,2]],[3,3]],[4,4]]').magnitude
  end

  def test_magnitude_4
    assert_equal 791, SnailfishNumber.new('[[[[3,0],[5,3]],[4,4]],[5,5]]').magnitude
  end

  def test_magnitude_5
    assert_equal 1137, SnailfishNumber.new('[[[[5,0],[7,4]],[5,5]],[6,6]]').magnitude
  end

  def test_magnitude_6
    assert_equal 3488, SnailfishNumber.new('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]').magnitude
  end

  def test_part1
    assert_equal 4140, described_class.new(input).part1
  end

  def test_part2
    assert_equal 3993, described_class.new(input).part2
  end
end
