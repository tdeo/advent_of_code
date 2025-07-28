# frozen_string_literal: true

class SnailfishNumber
  attr_accessor :left, :right, :value, :parent

  def initialize(string, parent = nil)
    middle = nil
    @parent = parent
    depth = 0
    string.to_s.each_char.with_index do |c, i|
      case c
      when '['
        depth += 1
      when ']'
        depth -= 1
      when ','
        middle = i if depth == 1
      end
    end
    @value = middle.nil? ? string.to_i : nil
    return unless middle

    @left = SnailfishNumber.new(string[1...middle], self)
    @right = SnailfishNumber.new(string[(middle + 1)...-1], self)
  end

  def magnitude
    return value if node?

    (3 * left.magnitude) + (2 * right.magnitude)
  end

  def node?
    !@value.nil?
  end

  def add(other)
    SnailfishNumber.new('0').tap do |num|
      num.value = nil
      num.left = self
      num.left.parent = num
      num.right = other
      num.right.parent = num
    end.tap(&:reduce)
  end

  def root
    current = self
    current = current.parent until current.parent.nil?
    current
  end

  def reduce
    loop do
      break unless explode || split
    end
  end

  def explode(depth = 0)
    return false if node?

    if depth < 4
      @left.explode(depth + 1) || @right.explode(depth + 1)
    elsif @left.node? && @right.node?
      @left.propagate_left
      @right.propagate_right
      @right = nil
      @left = nil
      @value = 0

      true
    elsif @left.node? || @right.node?
      raise 'not explodable, only one child is a value' if depth >= 4
    else # rubocop:todo Lint/DuplicateBranch
      @left.explode(depth + 1) || @right.explode(depth + 1)
    end
  end

  def split
    if node? && value >= 10
      @left = SnailfishNumber.new(value / 2, self)
      @right = SnailfishNumber.new(value - (value / 2), self)
      @value = nil
      return true
    end

    @left&.split || @right&.split
  end

  def other_child(child)
    parent.left == child ? parent.right : parent.left
  end

  def left_child?
    parent&.left == self
  end

  def right_child?
    parent&.right == self
  end

  def propagate_left
    current = self
    current = current.parent while current&.left_child?
    return if current.parent.nil?

    current = current.parent.left
    current = current.right until current.node?
    current.value += value
  end

  def propagate_right
    current = self
    current = current.parent while current&.right_child?
    return if current.parent.nil?

    current = current.parent.right
    current = current.left until current.node?
    current.value += value
  end

  def replace_with(other)
    @value = other.value
    @left = other.left
    @right = other.right
  end

  def to_s
    node? ? @value.to_s : "[#{left},#{right}]"
  end
end

class Snailfish
  def initialize(input)
    @input = input
  end

  def final_sum
    numbers = @input.split("\n").map { SnailfishNumber.new(_1) }

    numbers.reduce(&:add)
  end

  def part1
    final_sum.magnitude
  end

  def part2
    numbers = @input.split("\n")

    best = 0
    (0...numbers.size).each do |i|
      (0...numbers.size).each do |j|
        next if j == i

        mag = SnailfishNumber.new(numbers[i]).add(SnailfishNumber.new(numbers[j])).magnitude
        best = [best, mag].max
      end
    end
    best
  end
end
