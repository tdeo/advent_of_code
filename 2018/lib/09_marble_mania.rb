class MarbleMania
  def initialize(input)
    @input = input
    @players = @input[/^(\d+) player/, 1].to_i
    @marbles = @input[/last marble is worth (\d+) points/, 1].to_i
    @scores = Hash.new { |h, k| h[k] = 0 }
  end

  class Node
    attr_accessor :val
    attr_accessor :before
    attr_accessor :after

    def initialize(val)
      self.val = val
    end

    def insert_after(node)
      a = self.after
      a.before = node
      self.after = node
      node.after = a
      node.before = self
    end

    def delete_after
      self.after = self.after.after
      self.after.before = self
    end

    def delete_before
      self.before = self.before.before
      self.before.after = self
    end
  end

  def init!
    @current = Node.new(0)
    @current.before = @current
    @current.after = @current
    @next_val = 1
  end

  def print!
    acc = []
    a = @current
    while a.val != acc[0]
      acc << a.val
      a = a.after
      puts 'FAIL' if a.before.val != acc[-1]
    end
    puts acc.join(' ')
  end

  def play!
    if (@next_val % 23) != 0
      @current = @current.after
      @current.insert_after(Node.new(@next_val))
      @current = @current.after
    else
      player = (@next_val - 1) % @players
      @scores[player] += @next_val
      6.times { @current = @current.before }
      @scores[player] += @current.before.val
      @current.delete_before
    end
    @next_val += 1
  end


  def part1
    init!
    while @next_val <= @marbles
      play!
    end
    @scores.values.max
  end

  def part2
    @marbles *= 100
    part1
  end
end
