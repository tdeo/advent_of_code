# frozen_string_literal: true

require_relative '../../lib/priority_queue'

class Amphipod
  COST = { 'A' => 1, 'B' => 10, 'C' => 100, 'D' => 1000 }.freeze

  class Grid
    attr_accessor :burrows, :hall, :cost, :height

    def initialize(*burrows)
      @burrows = burrows
      @hall = [nil] * 7
      @cost = 0
      @height = burrows.map(&:size).max
    end

    def dup
      self.class.new(*burrows.map(&:dup)).tap do |ins|
        ins.hall = hall.dup
        ins.cost = cost
        ins.height = height
      end
    end

    def hall_char(idx)
      @hall[idx].nil? ? '.' : @hall[idx]
    end

    def burrow_char(i, j)
      @burrows[i][j].nil? ? '.' : @burrows[i][j]
    end

    def success?
      @burrows[0].all? { _1 == 'A' } &&
        @burrows[1].all? { _1 == 'B' } &&
        @burrows[2].all? { _1 == 'C' } &&
        @burrows[3].all? { _1 == 'D' } &&
        @hall.all?(&:nil?)
    end

    def hash
      [
        @hall.join('.'),
        *@burrows.map { _1.join(',') },
      ].join(' ')
    end

    def print
      puts <<~INFO.tr('=', '#')
        Cost: #{@cost}
        =============
        =#{hall_char(0)}#{(1..5).map { hall_char(_1) }.join('.')}#{hall_char(6)}=
      INFO

      (height - 1).downto(0).each do |i|
        puts "  =#{burrow_char(0, i)}=#{burrow_char(1, i)}=#{burrow_char(2, i)}=#{burrow_char(3, i)}=".tr('=', '#')
      end

      puts <<~INFO.tr('=', '#')
          =========
        Hash: #{hash}
      INFO
    end

    def options
      res = []

      # Fill A burrow
      if burrows[0].all? { _1 == 'A' }
        [
          [[1, 1], [0, 2]],
          [[2, 1], [3, 3], [4, 5], [5, 7], [6, 8]],
        ].each do |dir|
          closest = dir.find { !@hall[_1.first].nil? }
          next if closest.nil?

          idx, dist = closest
          next unless @hall[idx] == 'A'

          dist += height - @burrows[0].size

          modified = dup
          modified.hall[idx] = nil
          modified.burrows[0].push('A')
          modified.cost += dist * COST['A']
          res << modified
        end
      end

      # Fill B burrow
      if burrows[1].all? { _1 == 'B' }
        [
          [[2, 1], [1, 3], [0, 4]],
          [[3, 1], [4, 3], [5, 5], [6, 6]],
        ].each do |dir|
          closest = dir.find { !@hall[_1.first].nil? }
          next if closest.nil?

          idx, dist = closest
          next unless @hall[idx] == 'B'

          dist += height - @burrows[1].size

          modified = dup
          modified.hall[idx] = nil
          modified.burrows[1].push('B')
          modified.cost += dist * COST['B']
          res << modified
        end
      end

      # Fill C burrow
      if burrows[2].all? { _1 == 'C' }
        [
          [[3, 1], [2, 3], [1, 5], [0, 6]],
          [[4, 1], [5, 3], [6, 4]],
        ].each do |dir|
          closest = dir.find { !@hall[_1.first].nil? }
          next if closest.nil?

          idx, dist = closest
          next unless @hall[idx] == 'C'

          dist += height - @burrows[2].size

          modified = dup
          modified.hall[idx] = nil
          modified.burrows[2].push('C')
          modified.cost += dist * COST['C']
          res << modified
        end
      end

      # Fill D burrow
      if burrows[3].all? { _1 == 'D' }
        [
          [[4, 1], [3, 3], [2, 5], [1, 7], [0, 8]],
          [[5, 1], [6, 2]],
        ].each do |dir|
          closest = dir.find { !@hall[_1.first].nil? }
          next if closest.nil?

          idx, dist = closest
          next unless @hall[idx] == 'D'

          dist += height - @burrows[3].size

          modified = dup
          modified.hall[idx] = nil
          modified.burrows[3].push('D')
          modified.cost += dist * COST['D']
          res << modified
        end
      end

      # Empty A burrow
      if burrows[0].any? { _1 != 'A' }
        [
          [[1, 1], [0, 2]],
          [[2, 1], [3, 3], [4, 5], [5, 7], [6, 8]],
        ].each do |dir|
          dir.each do |idx, dist|
            break unless @hall[idx].nil?

            dist += height - @burrows[0].size + 1
            modified = dup
            modified.hall[idx] = modified.burrows[0].pop
            modified.cost += COST[modified.hall[idx]] * dist
            res << modified
          end
        end
      end

      # Empty B burrow
      if burrows[1].any? { _1 != 'B' }
        [
          [[2, 1], [1, 3], [0, 4]],
          [[3, 1], [4, 3], [5, 5], [6, 6]],
        ].each do |dir|
          dir.each do |idx, dist|
            break unless @hall[idx].nil?

            dist += height - @burrows[1].size + 1
            modified = dup
            modified.hall[idx] = modified.burrows[1].pop
            modified.cost += COST[modified.hall[idx]] * dist
            res << modified
          end
        end
      end

      # Empty C burrow
      if burrows[2].any? { _1 != 'C' }
        [
          [[3, 1], [2, 3], [1, 5], [0, 6]],
          [[4, 1], [5, 3], [6, 4]],
        ].each do |dir|
          dir.each do |idx, dist|
            break unless @hall[idx].nil?

            dist += height - @burrows[2].size + 1
            modified = dup
            modified.hall[idx] = modified.burrows[2].pop
            modified.cost += COST[modified.hall[idx]] * dist
            res << modified
          end
        end
      end

      # Empty D burrow
      if burrows[3].any? { _1 != 'D' }
        [
          [[4, 1], [3, 3], [2, 5], [1, 7], [0, 8]],
          [[5, 1], [6, 2]],
        ].each do |dir|
          dir.each do |idx, dist|
            break unless @hall[idx].nil?

            dist += height - @burrows[3].size + 1
            modified = dup
            modified.hall[idx] = modified.burrows[3].pop
            modified.cost += COST[modified.hall[idx]] * dist
            res << modified
          end
        end
      end

      res
    end
  end

  def initialize(input)
    @input = input
    @lines = @input.split("\n")
    burrows = [3, 5, 7, 9].map do |i|
      @lines[2...-1].map { |line| line[i] }.reject { _1 == '.' }.reverse
    end
    @grid = Grid.new(*burrows)
    @grid.hall = @lines[1].chars.values_at(1, 2, 4, 6, 8, 10, 11).map { _1 == '.' ? nil : _1}
  end

  def part1
    queue = PriorityQueue.new(&:cost)
    queue << @grid
    visited = {}

    until queue.empty?
      a = queue.pop
      next if visited[a.hash]

      visited[a.hash] = true

      return a.cost if a.success?

      a.options.each { queue << _1 }
    end
  end

  def part2
    lines = @input.split("\n")
    new_lines = [
      *lines[0..2],
      '  #D#C#B#A#',
      '  #D#B#A#C#',
      *lines[3..],
    ]
    self.class.new(new_lines.join("\n")).part1
  end
end
