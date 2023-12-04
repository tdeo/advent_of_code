# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class PriorityQueue
  extend T::Sig
  extend T::Generic

  Elem = type_member { { upper: Kernel } }

  sig { returns(Integer) }
  attr_reader :size

  sig do
    params(
      block: T.any(
        NilClass,
        T.proc.params(arg0: T.nilable(Elem)).returns(Integer),
        T.proc.params(arg0: T.nilable(Elem), arg1: T.nilable(Elem)).returns(Integer),
      ),
    ).void
  end
  def initialize(&block)
    @q = T.let([nil], T::Array[T.nilable(Elem)])
    @size = T.let(0, Integer)
    @block = block
  end

  sig { params(el: Elem).void }
  def <<(el)
    @size += 1
    @q << el
    bubble_up(@q.size - 1)
  end

  sig { returns(T.nilable(Elem)) }
  def pop
    @size -= 1
    exchange(1, @q.size - 1)
    el = @q.pop
    bubble_down(1)
    el
  end

  sig { returns(T::Boolean) }
  def empty?
    @q.size <= 1
  end

  private

  sig do
    params(
      a: T.nilable(Elem),
      b: T.nilable(Elem),
    ).returns(T::Boolean)
  end
  def lte(a, b)
    if @block.nil?
      T.must(a <=> b) <= 0
    elsif @block.arity == 2
      block = T.cast(@block, T.proc.params(arg0: T.nilable(Elem), arg1: T.nilable(Elem)).returns(Integer))
      block.call(a, b) <= 0
    else
      block = T.cast(@block, T.proc.params(arg0: T.nilable(Elem)).returns(Integer))
      block.call(a) <= block.call(b)
    end
  end

  sig { params(i: Integer, j: Integer).void }
  def exchange(i, j)
    @q[i], @q[j] = T.must(@q[j]), T.must(@q[i])
  end

  sig { params(i: Integer).void }
  def bubble_up(i)
    parent = i / 2
    return if i <= 1
    return if lte(T.must(@q[parent]), T.must(@q[i]))

    exchange(i, parent)
    bubble_up(parent)
  end

  sig { params(i: Integer).void }
  def bubble_down(i)
    child = 2 * i
    return if child >= @q.size

    lchild = @q[child]
    rchild = @q[child + 1]
    child += 1 if child < @q.size - 1 && lte(rchild, lchild)
    return if lte(T.must(@q[i]), T.must(@q[child]))

    exchange(i, child)
    bubble_down(child)
  end
end
