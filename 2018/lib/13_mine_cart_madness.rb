# frozen_string_literal: true

class MineCartMadness
  class Cart
    # include Comparable
    attr_accessor :i, :j, :dir, :turn, :dead

    def initialize(i, j, dir, turn = :left)
      self.i = i
      self.j = j
      self.dir = dir
      self.turn = turn
    end

    def <=>(other)
      return 0 if i == other.i && i == other.j

      i < other.i || (i == other.i && j < other.j) ? -1 : 1
    end

    def repr
      case dir
      when :left then '<'
      when :right then '>'
      when :up then '^'
      when :down then 'v'
      else ''
      end
    end
  end

  def initialize(input)
    @map = []
    @carts = []
    input.split("\n").each do |l|
      parse_row(l)
    end
  end

  def left_dir(dir)
    case dir
    when :left then :down
    when :down then :right
    when :right then :up
    when :up then :left
    end
  end

  def right_dir(dir)
    case dir
    when :left then :up
    when :up then :right
    when :right then :down
    when :down then :left
    end
  end

  def find_cart(i, j)
    @carts.find { |c| c.i == i && c.j == j }
  end

  def move(cart, save: false)
    i, j = case cart.dir
           when :left then [cart.i, cart.j - 1]
           when :right then [cart.i, cart.j + 1]
           when :up then [cart.i - 1, cart.j]
           when :down then [cart.i + 1, cart.j]
           end
    if find_cart(i, j)
      raise [j, i].join(',') unless save

      cart.dead = true
      find_cart(i, j).dead = true
    elsif @map[i][j] == '/'
      cart.dir = case cart.dir
                 when :up then :right
                 when :right then :up
                 when :left then :down
                 when :down then :left
                 end
    elsif @map[i][j] == '\\'
      cart.dir = case cart.dir
                 when :right then :down
                 when :down then :right
                 when :up then :left
                 when :left then :up
                 end
    elsif @map[i][j] == '+'
      case cart.turn
      when :left
        cart.dir = left_dir(cart.dir)
      when :right
        cart.dir = right_dir(cart.dir)
      end
      cart.turn = case cart.turn
                  when :left then :straight
                  when :straight then :right
                  when :right then :left
                  end
    end
    cart.i = i
    cart.j = j
  end

  def parse_row(l)
    return if l.empty?

    l.each_char.each_with_index do |c, j|
      case c
      when '<'
        @carts << Cart.new(@map.size, j, :left)
      when '>'
        @carts << Cart.new(@map.size, j, :right)
      when '^'
        @carts << Cart.new(@map.size, j, :up)
      when 'v'
        @carts << Cart.new(@map.size, j, :down)
      end
    end
    @map << l.tr('<>v^', '\-\-||')
  end

  def tick!(save: false)
    @carts.sort.each { |c| move(c, save: save) }
    @carts.reject!(&:dead)
  end

  def print!(carts: true)
    out = @map.map(&:dup)
    if carts
      @carts.each do |c|
        out[c.i][c.j] = c.repr
      end
    end
    puts out.join("\n")
  end

  def part1
    loop do
      tick!
    end
  rescue RuntimeError => e
    e.message
  end

  def part2
    loop do
      tick!(save: true)
      return [@carts.first.j, @carts.first.i].join(',') if @carts.size == 1
    end
  end
end
