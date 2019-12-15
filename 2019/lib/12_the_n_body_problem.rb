class TheNBodyProblem
  def initialize(input)
    @input = input
    @moons = input.split("\n").map do |l|
      {
        pos: l.split('=')[1..3].map(&:to_i),
        vel: [0, 0, 0],
      }
    end
  end

  def time_step
    @moons.combination(2).each do |a, b|
      [0, 1, 2].each do |i|
        if a[:pos][i] > b[:pos][i]
          a[:vel][i] -= 1
          b[:vel][i] += 1
        elsif a[:pos][i] < b[:pos][i]
          a[:vel][i] += 1
          b[:vel][i] -= 1
        end
      end
    end
    @moons.each do |a|
      [0, 1, 2].each do |i|
        a[:pos][i] += a[:vel][i]
      end
    end
  end

  def total_energy
    @moons.map do |a|
      a[:pos].map(&:abs).sum * a[:vel].map(&:abs).sum
    end.sum
  end

  def part1(steps = 1000)
    steps.times { time_step }
    total_energy
  end

  def find_cycle(idx)
    viewed = {}
    steps = 0
    while true do
      key = @moons.map { |v| [v[:pos][idx], v[:vel][idx]] }
      if viewed[key]
        return [viewed[key], steps - viewed[key]]
      end
      viewed[key] = steps
      time_step
      steps += 1
    end
  end

  def part2
    repeat = []
    [0, 1, 2].each do |i|
      sim = self.class.new(@input)
      repeat[i] = sim.find_cycle(i)
    end
    l = repeat.map(&:last).reduce(&:lcm)
    res = l + repeat.map(&:first).min
  end
end
