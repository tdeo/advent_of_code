class ExperimentalEmergencyTeleportation
  def initialize(input)
    @input = input
    @bots = []
    @input.split("\n").each do |l|
      @bots << l.match(/pos=<(-?\d+),(-?\d+),(-?\d+)>, r=(\d+)$/)[1..4].map(&:to_i)
    end
  end

  def dist(b1, b2)
    b1.zip(b2)[0..2].map { |a, b| (a - b).abs }.sum
  end

  def part1
    best_dist = 0
    best_bot = nil
    @bots.each do |bot|
      if bot[-1] > best_dist
        best_dist = bot[-1]
        best_bot = bot
      end
    end

    c = 0
    @bots.each do |bot|
      c += 1 if dist(best_bot, bot) <= best_dist
    end
    c
  end
  def connected?(i1, i2)
    return true if i1 == i2
    @connected ||= Hash.new { |h, k| h[k] = {} }
    @connected[i1][i2] ||= (dist(@bots[i1], @bots[i2]) <= @bots[i1][-1] + @bots[i2][-1])
  end

  def strongly_connected(idxs)
    return [[]] if idxs.empty?

    idxs.shuffle!

    a = idxs.first
    c = []
    nc = []
    idxs[1..-1].each do |i|
      connected?(a, i) ? (c << i) : (nc << i)
    end

    nc = strongly_connected(nc)
    c = strongly_connected(c)

    c.each { |e| e << a }

    res = []
    res += c if c.first.size >= nc.first.size
    res += nc if nc.first.size >= c.first.size

    res
  end

  def intersected_bots(point)
    @bots.select { |b| dist(b, point) <= b[-1] }
  end

  def intersect_count(point)
    intersected_bots(point).size
  end


  def part2
    part2a
  end

  def center_of_mass(bots)
    if @rmin.nil? || @rmax.nil?
      @rmin, @rmax = @bots.map(&:last).minmax
    end
    # puts @rmax, @rmin
    x = y = z = 0
    r = 0.0
    bots.each do |b|
      w = (2 * @rmax - b[3]) / (@rmax - @rmin)
      x += b[0] * w
      y += b[1] * w
      z += b[2] * w
      r += w
    end
    [x / r, y / r, z / r].map(&:round)
  end

  def part2c
    c = [0, 0, 0]
    bots = @bots
    12.times do
      c = center_of_mass(bots)
      puts intersect_count(c)
      bots = intersected_bots(c)
    end
  end

  def part2b
    xmin, xmax = @bots.map { |b| b[0] }.minmax
    ymin, ymax = @bots.map { |b| b[1] }.minmax
    zmin, zmax = @bots.map { |b| b[2] }.minmax
    step = @bots.map(&:last).min
    step /= 6

    (xmin..xmax).step(step).each do |x|
      (ymin..ymax).step(step).each do |y|
        (zmin..zmax).step(step).each do |z|
          puts "#{x} #{y} #{z} #{intersect_count([x, y, z])}" if intersect_count(x, y, z) > 700
        end
      end
    end
  end

  def part2a
    (0...@bots.size).each do |i|
      (0...@bots.size).each do |j|
        connected?(i, j)
      end
    end

    comp = strongly_connected (0...@bots.size).to_a
    puts "Biggest component size: #{comp[0].size}"
    fail if comp.size != 1 # Edge case not handled

    r = 0
    comp[0].each do |i|
      r = [
        r,
        @bots[i][0..2].map(&:abs).sum - @bots[i][-1],
      ].max
    end
    r
  end
end
