class CrossedWires
  def initialize(input)
    @input = input
    @u, @v = @input.split("\n").map { |l| l.split(?,) }
  end

  def path(wire)
    x = 0
    y = 0
    wire.each do |step|
      dir = step[0]
      count = step[1..-1].to_i
      count.times do
        y += 1 if dir == ?U
        y -= 1 if dir == ?D
        x -= 1 if dir == ?L
        x += 1 if dir == ?R
        yield [x, y]
      end
    end
  end

  def part1
    vis = Hash.new { |h, k| h[k] = {} }
    path(@u) do |x, y|
      vis[x][y] = true
    end
    best = 1e14
    path(@v) do |x, y|
      next unless vis[x][y]
      best = x.abs + y.abs if x.abs + y.abs < best
    end
    best
  end

  def part2
    vis = Hash.new { |h, k| h[k] = {} }
    i = 0
    path(@u) do |x, y|
      i += 1
      vis[x][y] = i
    end
    best = 1e14

    i = 0
    path(@v) do |x, y|
      i += 1
      next unless vis[x][y]
      best = i + vis[x][y] if i + vis[x][y] < best
    end
    best
  end
end
