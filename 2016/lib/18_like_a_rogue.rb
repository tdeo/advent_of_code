class LikeARogue
  def initialize(input)
    @rows = []
    @rows[0] = input.strip
  end

  def above_chars(i)
    (i == 0 ? '.' : '') + @rows.last[[i - 1, 0].max .. [i + 1, @rows.last.size - 1].min] + (i == @rows.last.size - 1 ? '.' : '')
  end

  def next_row!
    row = @rows.last
    @rows << (0...row.size).map do |i|
      case above_chars(i)
      when '^^.' then '^'
      when '.^^' then '^'
      when '^..' then '^'
      when '..^' then '^'
      else '.'
      end
    end.join('')
  end

  def part1(rows = 40)
    while @rows.size < rows
      next_row!
    end
    @rows.map { |r| r.tr('^', '').size }.reduce(:+)
  end

  def part2(rows = 400_000)
    visited = { @rows.last => 0 }
    while @rows.size < rows
      next_row!
      puts "Visited #{visited[@rows.last]} #{@rows.size}" if visited.key?(@rows.last)
      visited[@rows.last] = @rows.size
    end
    @rows.map { |r| r.tr('^', '').size }.reduce(:+)
  end
end
