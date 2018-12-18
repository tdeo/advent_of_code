class SettlersofTheNorthPole
  def initialize(input)
    @input = input
    @map = input.split("\n")
  end

  def neighbours(i, j)
    r = Hash.new { |h, k| h[k] = 0 }
    (i - 1 .. i + 1).each do |ii|
      next if ii < 0 || ii >= @map.size
      (j - 1 .. j + 1).each do |jj|
        next if jj < 0 || jj >= @map[i].size
        next if jj == j && ii == i
        r[@map[ii][jj]] += 1
      end
    end
    r
  end

  def round
    tmp = []
    @map.each_with_index do |row, i|
      r = ''
      row.each_char.each_with_index do |c, j|
        n = neighbours(i, j)
        if c == '.'
          if n['|'] >= 3
            r << '|'
          else
            r << '.'
          end
        elsif c == '|'
          if n['#'] >= 3
            r << '#'
          else
            r << '|'
          end
        elsif c == '#'
          if n['#'] >= 1 && n['|'] >= 1
            r << '#'
          else
            r << '.'
          end
        end
      end
      tmp << r
    end
    @map = tmp
  end

  def count(c)
    @map.map { |r| r.chars.count(c) }.sum
  end

  def print!
    puts @map.join("\n")
  end

  def value
    count('|') * count('#')
  end

  def part1
    10.times do
      round
    end
    value
  end

  def fingerprint
    @map.join('')
  end

  def part2
    values = {}

    n = 1_000_000_000

    n.times do |i|
      v = fingerprint
      if values[v]
        period = i - values[v]
        while (n - i) % period != 0
          i += 1
          round
        end
        return value
      end
      values[v] = i

      round
    end
  end
end
