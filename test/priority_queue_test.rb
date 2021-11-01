# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/priority_queue'

describe PriorityQueue do
  before { @k = PriorityQueue }

  def test_no_block
    q = @k.new
    q << 7
    q << 3
    q << 5
    q << 1
    q << 8
    assert_equal 1, q.pop
    assert_equal 3, q.pop
    assert_equal 5, q.pop
    assert_equal 7, q.pop
    assert_equal 8, q.pop
  end

  def test_proc
    q = @k.new { |a| a.last + 1 }
    q << ['a', 7]
    q << ['b', 3]
    q << ['c', 5]
    q << ['d', 1]
    q << ['e', 8]
    assert_equal ['d', 1], q.pop
    assert_equal ['b', 3], q.pop
    assert_equal ['c', 5], q.pop
    assert_equal ['a', 7], q.pop
    assert_equal ['e', 8], q.pop
  end

  def test_block_arity_1
    q = @k.new(&:last)
    q << ['a', 7]
    q << ['b', 3]
    q << ['c', 5]
    q << ['d', 1]
    q << ['e', 8]
    assert_equal ['d', 1], q.pop
    assert_equal ['b', 3], q.pop
    assert_equal ['c', 5], q.pop
    assert_equal ['a', 7], q.pop
    assert_equal ['e', 8], q.pop
  end

  def test_block_arity_2
    q = @k.new { |a, b| a.last - b.last }
    q << ['a', 7]
    q << ['b', 3]
    q << ['c', 5]
    q << ['d', 1]
    q << ['e', 8]
    assert_equal ['d', 1], q.pop
    assert_equal ['b', 3], q.pop
    assert_equal ['c', 5], q.pop
    assert_equal ['a', 7], q.pop
    assert_equal ['e', 8], q.pop
  end
end
