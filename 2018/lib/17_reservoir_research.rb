class ReservoirResearch
  def initialize(input)
    @input = input
    @map = Hash.new { |h, k| h[k] = {} }

    @maxy = 0
    @miny = 2000

    @count = 0
    @static = 0

    @input.split("\n").each do |l|
      m = l.match(/^(x|y)=(\d+), (x|y)=(\d+)..(\d+)$/)
      val = m[2].to_i
      (m[4].to_i .. m[5].to_i).each do |a|
        if m[1] == 'x'
          @miny = [@miny, a].min
          @maxy = [@maxy, a].max
          @map[val][a] = '#'
        else
          @miny = [@miny, val].min
          @maxy = [@maxy, val].max
          @map[a][val] = '#'
        end
      end
    end
  end

  def flow(x, y)
    # puts "\e[2J\e[1;1H"
    # print!(y - 10, y + 30)
    # sleep 0.02
    return if y > @maxy
    if @map[x][y].nil?
      @count += 1 if y >= @miny
      @map[x][y] = '|'
    end
    if @map[x][y + 1].nil?
      @count += 1 if y >= @miny - 1 && y < @maxy
      @map[x][y + 1] = '|'
      flow(x, y + 1)
    elsif @map[x][y + 1] == '#' || @map[x][y + 1] == '~'
      left = right = nil

      a = x
      while @map[a][y + 1] == '#' || @map[a][y + 1] == '~'
        a -= 1
        if @map[a][y].nil?
          @count += 1 if y >= @miny
          @map[a][y] = '|'
        elsif @map[a][y] == '#'
          left = :block
          break
        end
        left = a
      end

      a = x
      while @map[a][y + 1] == '#' || @map[a][y + 1] == '~'
        a += 1
        if @map[a][y].nil?
          @count += 1 if y >= @miny
          @map[a][y] = '|'
        elsif @map[a][y] == '#'
          right = :block
          break
        end
        right = a
      end

      flow(left, y) if left != :block
      flow(right, y) if right != :block

      if (left == :block && right == :block)
        static(x, y)
        flow(x, y - 1)
      end
    end
  end

  def print!(ymin = 0, ymax = nil)
    ymax ||= @ymax
    str = (ymin..ymax).map do |y|
      (400..600).map do |x|
        @map[x][y] || ' '
      end.join('')
    end.join("\n")
    puts str
  end

  def static(x, y)
    if @map[x][y] == '|'
      @static += 1
      @map[x][y] = '~'
    end
    a = x + 1
    while @map[a][y] == '|'
      @map[a][y] = '~'
      @static += 1
      a += 1
    end
    a = x - 1
    while @map[a][y] == '|'
      @map[a][y] = '~'
      @static += 1
      a -= 1
    end
  end

  def part1
    flow(500, 0)
    @count
  end

  def part2
    flow(500, 0)
    @static
  end
end
