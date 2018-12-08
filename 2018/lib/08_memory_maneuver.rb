class MemoryManeuver
  def initialize(input)
    @input = input.split(' ').map(&:to_i)
  end

  class Node
    attr_accessor :n_children, :n_metadata, :children, :metadata, :size

    def initialize
      self.children = []
      self.metadata = []
    end
  end

  def parse(i = 0)
    a = Node.new
    a.n_children = @input[i]
    a.n_metadata = @input[i + 1]
    i += 2
    a.n_children.times do
      child, i = parse(i)
      a.children << child
    end
    a.n_metadata.times do
      a.metadata << @input[i]
      i += 1
    end
    [a, i]
  end

  def metadata_sum(node)
    res = node.metadata.sum
    node.children.each { |c| res += metadata_sum(c) }
    res
  end

  def part1
    metadata_sum(parse.first)
  end

  def value(node)
    return node.metadata.sum if node.n_children == 0
    node.metadata.map do |i|
      next if i <= 0 || i > node.n_children
      value(node.children[i - 1])
    end.compact.sum
  end

  def part2
    value(parse.first)
  end
end
