class PlanetofDiscord
  def initialize(input)
    @input = input.strip
    @grid = @input.split("\n")
    @n = @grid.size
  end

  def neighbours(i, j)
    [[i, j + 1], [i, j - 1], [i + 1, j], [i - 1, j]].count do |ii, jj|
      ii >= 0 && jj >= 0 && ii < @n && jj < @n && @grid[ii][jj] == ?#
    end
  end

  def step!
    next_grid = @grid.map(&:dup)
    (0...@n).each do |i|
      (0...@n).each do |j|
        if @grid[i][j] == ?# && neighbours(i, j) != 1
          next_grid[i][j] = ?.
        elsif @grid[i][j] == ?. && (1..2) === neighbours(i, j)
          next_grid[i][j] = ?#
        else
          next_grid[i][j] = @grid[i][j]
        end
      end
    end
    @grid = next_grid
  end

  def biovalue
    val = 0
    @grid.join.chars.each_with_index do |c, i|
      val |= (1 << i) if c == ?#
    end
    val
  end

  def print_grid
    puts @grid.join("\n")
    puts ''
  end

  def part1
    v = {}
    while true
      val = biovalue
      return val if v[val]
      v[val] = true
      step!
    end
  end

  NEIGHBOURS = {
    1 => [2, 6, [-1, 8], [-1, 12]],
    2 => [1, 3, 7, [-1, 8]],
    3 => [2, 4, 8, [-1, 8]],
    4 => [3, 5, 9, [-1, 8]],
    5 => [4, 10, [-1, 8], [-1, 14]],
    6 => [1, 7, 11, [-1, 12]],
    7 => [2, 6, 8, 12],
    8 => [3, 7, 9, [1, 1], [1, 2], [1, 3], [1, 4], [1, 5]],
    9 => [4, 8, 10, 14],
    10 => [5, 9, 15, [-1, 14]],
    11 => [6, 12, 16, [-1, 12]],
    12 => [7, 11, 17, [1, 1], [1, 6], [1, 11], [1, 16], [1, 21]],
    13 => nil,
    14 => [9, 15, 19, [1, 5], [1, 10], [1, 15], [1, 20], [1, 25]],
    15 => [10, 14, 20, [-1, 14]],
    16 => [11, 17, 21, [-1, 12]],
    17 => [12, 16, 18, 22],
    18 => [17, 19, 23, [1, 21], [1, 22], [1, 23], [1, 24], [1, 25]],
    19 => [14, 18, 20, 24],
    20 => [15, 19, 25, [-1, 14]],
    21 => [16, 22, [-1, 12], [-1, 18]],
    22 => [17, 21, 23, [-1, 18]],
    23 => [18, 22, 24, [-1, 18]],
    24 => [19, 23, 25, [-1, 18]],
    25 => [20, 24, [-1, 14], [-1, 18]],
  }.freeze

  def part2_step(grid)
    next_grid = Hash.new { |h, k| h[k] = Hash.new(?.) }
    (grid.keys.min - 1 .. grid.keys.max + 1).each do |level|
      (1..25).each do |cell|
        next if cell == 13
        val = NEIGHBOURS[cell].count do |n|
          if n.is_a?(Array)
            grid[level + n[0]][n[1]] == ?#
          else
            grid[level][n] == ?#
          end
        end
        if grid[level][cell] == ?. && (1..2) === val
          next_grid[level][cell] = ?#
        elsif grid[level][cell] == ?# && val == 1
          next_grid[level][cell] = ?#
        end
      end
    end
    next_grid
  end

  def print_level(grid)
    puts "**"
    (1..25).each_slice(5) do |s|
      puts s.map { |e| grid[e] }.join
    end
    puts "**"
  end

  def part2(minutes = 200)
    grid = Hash.new { |h, k| h[k] = Hash.new(?.) }
    grid[13] = ??

    @grid.join.chars.each_with_index do |c, i|
      grid[0][i + 1] = c if c != ?.
    end

    minutes.times do
      grid = part2_step(grid)
    end

    grid.sum do |_, v|
      v.values.count(?#)
    end
  end
end
