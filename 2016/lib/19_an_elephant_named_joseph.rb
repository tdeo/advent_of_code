class AnElephantNamedJoseph
  def initialize(input)
    @elves = (1..input.strip.to_i).to_a
  end

  def part1
    i = 0
    @elves = init_node(@elves)
    while @elves.size > 1
      to_delete = (i + 1) % @elves.size
      i = to_delete % @elves.size
      @elves.delete_at(to_delete)
    end
    @elves.value
  end

  def part2
    i = 0
    @elves = init_node(@elves)
    while @elves.size > 1
      to_delete = (i + @elves.size / 2) % @elves.size
      i = (i + 1) % @elves.size unless (to_delete % @elves.size) < (i % @elves.size)
      @elves.delete_at(to_delete).to_s
    end
    @elves.value
  end
end

def init_node(array, parent = nil)
  return nil if array.size == 0
  n = Node.new(array.first, array.size, parent, [])
  return n if array.size == 1
  a, b = init_node(array[1..array.size / 2], n), init_node(array[array.size / 2 + 1..-1], n)
  n.children = [a, b].compact
  n
end

Node = Struct.new(:value, :size, :parent, :children) do
  def pp(nested = 0)
    print ' ' * 2 * nested
    puts "#{value} (#{size} - #{children.size})"
    children.each { |c| c.pp(nested + 1) }
  end

  def delete_at(idx)
    return nil if idx < 0 || idx >= size
    self.size -= 1
    if idx == 0
      to_return = value
      if children.empty?
        parent.children.delete_if { |c| c.value == self.value }
      else
        child = children.first
        self.value = child.value
        self.children = child.children + children[1..-1]
        child.children.each { |c| c.parent = self }
      end
      return to_return
    else
      idx -= 1
      children.each do |c|
        if idx < c.size
          return c.delete_at(idx)
        else
          idx -= c.size
        end
      end
    end
  end
end
