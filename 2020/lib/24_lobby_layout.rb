# frozen_string_literal: true

class LobbyLayout
  def initialize(input)
    @input = input
    @flipped = {}
  end

  def perform(path)
    pos = [0, 0] # south, east
    north_south = %w[s n]
    i = 0
    while i < path.size
      char = path[i]

      if north_south.include?(char)
        case char
        when 's' then pos[0] += 1
        when 'n' then pos[0] -= 1
        end

        case path[i + 1]
        when 'e' then pos[1] += 1
        when 'w' then pos[1] -= 1
        end
        i + 2
      else
        case char
        when 'e' then pos[1] += 2
        when 'w' then pos[1] -= 2
        end
        i += 1
      end
    end
    if @flipped[pos]
      @flipped.delete(pos)
    else
      @flipped[pos] = true
    end
  end

  def part1
    @input.each_line { perform _1 }
    @flipped.size
  end

  def print!
    imin, imax = @flipped.keys.map(&:first).minmax
    jmin, jmax = @flipped.keys.map(&:last).minmax

    (imin..imax).each do |i|
      (jmin..jmax).each do |j|
        if i == 0 && j == 0
          print @flipped[[0, 0]] ? '0' : 'o'
        elsif (i + j).odd?
          print ' '
        elsif @flipped[[i, j]]
          print '#'
        else
          print '.'
        end
      end
      puts ''
    end
    puts ''
  end

  def neighbours(i, j)
    [
      [i + 1, j - 1],
      [i + 1, j + 1],
      [i - 1, j - 1],
      [i - 1, j + 1],
      [i, j + 2],
      [i, j - 2],
    ].count { |e| @flipped[e] }
  end

  def part2(days: 100)
    part1

    days.times do
      succ = {}

      imin, imax = @flipped.keys.map(&:first).minmax
      jmin, jmax = @flipped.keys.map(&:last).minmax

      ((imin - 1)..(imax + 1)).each do |i|
        ((jmin - 2)..(jmax + 2)).each do |j|
          next unless (i + j).even?

          n = neighbours(i, j)
          black = if @flipped[[i, j]]
                    n > 0 && n < 3
                  else
                    n == 2
                  end

          succ[[i, j]] = true if black
        end
      end
      @flipped = succ
    end
    @flipped.size
  end
end
