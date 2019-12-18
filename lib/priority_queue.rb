class PriorityQueue
  attr_reader :size

  def initialize(&block)
    @q = [nil]
    @block = block
    @size = 0
    fail 'Unrecognized block arity' if block && (block.arity < 1 || block.arity > 2)
  end

  def <<(el)
    @size += 1
    @q << el
    bubble_up(@q.size - 1)
  end

  def pop
    @size -= 1
    exchange(1, @q.size - 1)
    el = @q.pop
    bubble_down(1)
    el
  end

  def empty?
    @q.size <= 1
  end

  private

  def lte(a, b)
    if @block.nil?
      (a <=> b) <= 0
    elsif @block.arity == 1
      @block.call(a) <= @block.call(b)
    else
      @block.call(a, b) <= 0
    end
  end

  def exchange(a, b)
    @q[a], @q[b] = @q[b], @q[a]
  end

  def bubble_up(i)
    parent = i / 2
    return if i <= 1
    return if lte(@q[parent], @q[i])
    exchange(i, parent)
    bubble_up(parent)
  end

  def bubble_down(i)
    child = 2*i
    return if child >= @q.size
    lchild = @q[child]
    rchild = @q[child + 1]
    child += 1 if child < @q.size - 1 && lte(rchild, lchild)
    return if lte(@q[i], @q[child])
    exchange(i, child)
    bubble_down(child)
  end
end
