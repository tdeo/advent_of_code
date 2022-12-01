# frozen_string_literal: true

class Array
  def <(other)
    self[0] < other[0] || (self[0] == other[0] && self[1] < other[1])
  end
end

class BeverageBandits
  class Map
    attr_reader :units, :grid

    def initialize(input, elf_attack)
      @grid = []
      @units = []

      input.split("\n").each_with_index do |l, i|
        r = []
        l.each_char.with_index do |c, j|
          case c
          when '#'
            r << false
          when '.'
            r << true
          when 'G'
            r << Unit.new(i, j, :G, self)
            @units << r[-1]
          when 'E'
            r << Unit.new(i, j, :E, self)
            r[-1].attack = elf_attack
            @units << r[-1]
          end
        end
        @grid << r
      end
    end

    def free?(i, j)
      i >= 0 && j >= 0 && i < @grid.size && j < @grid[i].size && @grid[i][j] == true
    end

    def at(i, j)
      @grid[i][j]
    end

    def neighbours(i, j, free: false)
      [[i, j + 1], [i, j - 1], [i + 1, j], [i - 1, j]].select do |n|
        free?(*n) || free
      end
    end

    def dist(i, j, i2, j2, bound: nil)
      return nil if bound && (i2 - i).abs + (j2 - j).abs > bound
      return 0 if i == i2 && j == j2

      q = [[i, j, 0]]
      vis = { [i, j] => true }
      until q.empty?
        cur = q.shift
        next if bound && cur[2] > bound

        neighbours(cur[0], cur[1], free: true).each do |n|
          return cur[2] + 1 if n == [i2, j2]
          next unless free?(*n)
          next if vis[n]

          q << [n[0], n[1], cur[2] + 1]
          vis[n] = true
        end
      end
      nil
    end

    def round
      @units.sort_by! { |u| [u.i, u.j] }
      @units.each(&:play!)
      @units.delete_if { |u| u.health <= 0 }
    end

    def repr(life: true)
      @grid.map do |l|
        healths = []
        l.map do |u|
          case u
          when true then '.'
          when false then '#'
          when Unit
            healths << u.health
            u.type.to_s
          end
        end.join + (life ? " #{healths.join(', ')}" : '')
      end.join("\n")
    end
  end

  class Unit
    attr_reader :i, :j, :type, :health
    attr_writer :attack

    def initialize(i, j, type, map)
      @i = i
      @j = j
      @type = type
      @map = map
      @attack = 3
      @health = 200
    end

    def dist(i, j, bound: nil)
      @map.dist(i, j, @i, @j, bound: bound)
    end

    def in_range?
      [[@i, @j + 1], [@i, @j - 1], [@i - 1, @j], [@i + 1, j]].any? do |pos|
        @map.at(*pos).is_a?(Unit) && @map.at(*pos).type != @type
      end
    end

    def targets
      @map.units.select { |u| u.health > 0 && u.type != @type }
    end

    def attack_points
      points = []
      targets.each do |t|
        points += @map.neighbours(t.i, t.j)
      end
      points
    end

    def destination
      best = nil
      closest = nil
      attack_points.each do |a|
        d = dist(*a, bound: best)
        next if d.nil?

        if d < (best || Float::INFINITY) || (d == best && a < closest)
          best = d
          closest = a
        end
      end
      closest
    end

    def best_move
      dest = destination
      return nil if dest.nil?

      best = closest = nil

      @map.neighbours(i, j).each do |n|
        d = @map.dist(*n, *dest, bound: best)
        next if d.nil?

        if d < (best || Float::INFINITY) || (d == best && n < closest)
          best = d
          closest = n
        end
      end
      closest
    end

    def move_to(dest_i, dest_j)
      @map.grid[i][j] = true
      @map.grid[dest_i][dest_j] = self
      @i = dest_i
      @j = dest_j
    end

    def ennemy
      enemies = []
      [[@i - 1, @j], [@i, @j - 1], [@i, @j + 1], [@i + 1, @j]].each do |pos|
        u = @map.at(*pos)
        enemies << u if u.is_a?(Unit) && u.type != @type
      end
      enemies.min_by { |e| [e.health, e.i, e.j] }
    end

    def attack(e)
      e&.damage(@attack)
    end

    def damage(dmg)
      @health -= dmg
      @map.grid[@i][@j] = true if @health <= 0
    end

    def play!
      return if @health <= 0

      m = best_move
      move_to(*m) unless in_range? || m.nil?
      attack(ennemy)
    end
  end

  def initialize(input)
    @input = input
    elf_attack = 3
    @map = Map.new(input, elf_attack)
  end

  def round
    @map.round
  end

  def repr(life: true)
    @map.repr(life: life)
  end

  def part1(final_result: true)
    i = 0
    while @map.units.map(&:type).uniq.size > 1
      round
      i += 1
      # puts i
      # puts repr if i % 10 == 0 || i >= 90
    end
    r = [i - 1, @map.units.sum(&:health)]
    # puts r.inspect
    final_result ? r.reduce(:*) : r
  end

  def part2
    up = 300
    low = 3
    elves_count = @map.units.count { |u| u.type == :E }
    # Up wins for sure, low looses
    while up > low + 1
      m = (up + low) / 2
      @map = Map.new(@input, m)
      loop do
        round
        if @map.units.count { |u| u.type == :E } < elves_count
          low = m
          puts "Elves loose with power #{m}"
          break
        elsif @map.units.count { |u| u.type == :G } == 0
          up = m
          puts "Elves win with power #{m}"
          break
        end
      end
    end

    @map = Map.new(@input, up)
    part1
  end
end
