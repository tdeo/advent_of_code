class Swarn
  def initialize(input)
    @particles = []
    input.strip.each_line do |l|
      position, velocity, acceleration = l.split(', ').map(&:strip).map do |token|
        m = /^[pva]=<(-?\d+),(-?\d+),(-?\d+)>$/.match(token)
        m[1..3].map(&:to_i)
      end
      @particles << { idx: @particles.size, position: position, velocity: velocity, acceleration: acceleration }
    end
  end

  def abs_acceleration(particle)
    particle[:acceleration].map(&:abs).reduce(0, :+)
  end

  def velocity_acceleration_colinearity(particle)
    particle[:acceleration].zip(particle[:velocity]).map { |c| c.reduce(1, :*) }.reduce(0, :+)
  end

  def part1
    lowest_acceleration = @particles.map { |part| abs_acceleration(part) }.min
    slowest = @particles.select { |part| abs_acceleration(part) == lowest_acceleration }
    return slowest.first[:idx] if slowest.size == 1
    lowest_colinearity = slowest.map { |part| velocity_acceleration_colinearity(part) }.min
    slowest_bis = slowest.select { |part| velocity_acceleration_colinearity(part) == lowest_colinearity }
    return slowest_bis.first[:idx] if slowest_bis.size == 1
    nil
  end

  def move_part!(particle)
    return if particle[:collided]
    (0...3).each do |i|
      particle[:velocity][i] += particle[:acceleration][i]
      particle[:position][i] += particle[:velocity][i]
    end
  end

  def move!
    @particles.each { |part| move_part!(part) }
  end

  def resolve_collisions!
    collisions = Hash.new { |h, k| h[k] = [] }
    @particles.each do |part|
      next if part[:collided]
      collisions[part[:position]] << part[:idx]
    end
    collisions.each do |pos, parts|
      next unless parts.size > 1
      parts.each { |i| @particles[i][:collided] = true }
    end
  end

  def part2
    resolve_collisions!
    1_000.times do |i|
      move!
      resolve_collisions!
    end
    @particles.count { |part| !part[:collided] }
  end
end
