class Fractal
  def initialize(input, times = 5)
    @grid = '.#. ..# ###'.split(' ').map(&:chars)
    @rules = {}
    @times = times
    expand_rules(input)
  end

  def print_grid
    puts @grid.map { |r| r.join('') }
  end

  def expand_rules(input)
    input.split("\n").map { |l| l.strip.split(' => ') }.each do |pattern, output|
      variants(pattern).each do |v|
        @rules[v] = output
      end
    end
  end

  def variants(pattern)
    if pattern.size == 5 # 2 by 2
      ['abcd', 'bdac', 'dcba', 'cadb',
       'badc', 'dbca', 'cdab', 'acbd'].map do |v|
        str = v[0..1] + '/' + v[2..3]
        str.tr('a', pattern[0]).tr('b', pattern[1]).tr('c', pattern[3]).tr('d', pattern[4])
      end
    elsif pattern.size == 11 # 3 by 3
      ['abcdefghi', 'cfibehadg', 'ihgfedcba', 'gdahebifc',
       'cbafedihg', 'ifchebgda', 'ghidefabc', 'adgbehcfi'].map do |v|
        str = v[0..2] + '/' + v[3..5] + '/' + v[6..8]
        str.tr('a', pattern[0]).tr('b', pattern[1]).tr('c', pattern[2])
          .tr('d', pattern[4]).tr('e', pattern[5]).tr('f', pattern[6])
          .tr('g', pattern[8]).tr('h', pattern[9]).tr('i', pattern[10])
      end
    else
      fail 'wrong pattern size'
    end
  end

  def split(grid)
    parts = []
    if grid.size % 2 == 0
      size = 2
    elsif grid.size % 3 == 0
      size = 3
    else
      fail 'Grid can\'t be split'
    end
    i = 0
    while @grid[i]
      j = 0
      while @grid[i][j]
        parts << @grid[i...i + size].map { |row| row[j...j + size].join('') }.join('/')
        j += size
      end
      i += size
    end
    parts
  end

  def aggregate(parts)
    c = Math.sqrt(parts.size).to_i
    size = parts.first.split('/').size
    grid = []
    c.times do |i|
      c.times do |j|
        parts.shift.split('/').each_with_index do |part, i2|
          part.chars.each_with_index do |char, j2|
            grid[i * size + i2] ||= []
            grid[i * size + i2][j * size + j2] = char
          end
        end
      end
    end
    grid
  end

  def replace(parts)
    parts.map { |part| @rules[part] }
  end

  def part1
    @times.times do
      @grid = aggregate(replace(split(@grid)))
    end
    @grid.map { |row| row.count { |c| c == '#' } }.reduce(0, :+)
  end

  def part2
    @times = 18
    @times.times do
      @grid = aggregate(replace(split(@grid)))
    end
    @grid.map { |row| row.count { |c| c == '#' } }.reduce(0, :+)
  end
end
