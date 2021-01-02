# frozen_string_literal: true

class MarbleMania
  def initialize(input)
    @input = input
    @players = @input[/^(\d+) player/, 1].to_i
    @marbles = @input[/last marble is worth (\d+) points/, 1].to_i
    @scores = Hash.new { |h, k| h[k] = 0 }
  end

  class Node
    attr_accessor :val, :before, :after

    def initialize(val)
      self.val = val
    end

    def insert_after(node)
      a = after
      a.before = node
      self.after = node
      node.after = a
      node.before = self
    end

    def delete_after
      self.after = after.after
      after.before = self
    end

    def delete_before
      self.before = before.before
      before.after = self
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
    if (@next_val % 23) == 0
      player = (@next_val - 1) % @players
      @scores[player] += @next_val
      6.times { @current = @current.before }
      @scores[player] += @current.before.val
      @current.delete_before
    else
      @current = @current.after
      @current.insert_after(Node.new(@next_val))
      @current = @current.after
    end
    @next_val += 1
  end

  def part1
    init!
    play! while @next_val <= @marbles
    @scores.values.max
  end

  def part2
    @marbles *= 100
    part1
  end
end
