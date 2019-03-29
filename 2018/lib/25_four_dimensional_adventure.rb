class FourDimensionalAdventure
  def initialize(input)
    @stars = []
    @dist = Hash.new { |h, k| h[k] = {} }
    input.split("\n").each do |l|
      @stars << l.split(',').map(&:to_i)
    end
  end

  def dist(i, j)
    i, j = j, i if j < i
    @dist[i][j] ||= begin
      @stars[i].zip(@stars[j]).map { |e| (e[0] - e[1]).abs }.sum
    end
  end

  def connected(i, j)
    dist(i, j) <= 3
  end

  def part1
    neighbours = Hash.new { |h, k| h[k] = [] }
    todo = {}

    (0...@stars.size).each do |i|
      todo[i] = true
      (0...i).each do |j|
        next unless connected(i, j)
        neighbours[i] << j
        neighbours[j] << i
      end
    end

    components = 0

    while true
      return components if todo.empty?

      q = [todo.keys.first]
      todo.delete(q[0])
      components += 1

      while !q.empty?
        a = q.shift
        neighbours[a].each do |n|
          next unless todo[n]
          q << n
          todo.delete(n)
        end
      end
    end
  end

  def part2
    0
  end
end
