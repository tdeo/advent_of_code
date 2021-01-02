# frozen_string_literal: true

class AnElephantNamedJoseph
  def initialize(input)
    @elves = (1..input.strip.to_i).to_a
  end

  def part1
    i = 0
    @elves = init_node(@elves)
    while @elves.total > 1
      to_delete = (i + 1) % @elves.total
      i = to_delete % @elves.total
      @elves.delete_at(to_delete)
    end
    @elves.value
  end

  def part2
    i = 0
    @elves = init_node(@elves)
    while @elves.total > 1
      to_delete = (i + @elves.total / 2) % @elves.total
      i = (i + 1) % @elves.total unless (to_delete % @elves.total) < (i % @elves.total)
      @elves.delete_at(to_delete).to_s
    end
    @elves.value
  end
end

def init_node(array, parent = nil)
  return nil if array.empty?

  n = Node.new(array.first, array.size, parent, [])
  return n if array.size == 1

  a = init_node(array[1..array.size / 2], n)
  b = init_node(array[array.size / 2 + 1..], n)
  n.children = [a, b].compact
  n
end

Node = Struct.new(:value, :total, :parent, :children) do
  def pp(nested = 0)
    print ' ' * 2 * nested
    puts "#{value} (#{total} - #{children.total})"
    children.each { |c| c.pp(nested + 1) }
  end

  def delete_at(idx)
    return nil if idx < 0 || idx >= total

    self.total -= 1
    if idx == 0
      to_return = value
      if children.empty?
        parent.children.delete_if { |c| c.value == value }
      else
        child = children.first
        self.value = child.value
        self.children = child.children + children[1..]
        child.children.each { |c| c.parent = self }
      end
      to_return
    else
      idx -= 1
      children.each do |c|
        return c.delete_at(idx) if idx < c.total

        idx -= c.total
      end
    end
  end
end
