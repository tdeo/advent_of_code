# frozen_string_literal: true

class TheNBodyProblem
  N = 3

  def initialize(input)
    @input = input
    @moons = input.split("\n").map do |l|
      {
        pos: l.split('=')[1..N].map(&:to_i),
        vel: [0, 0, 0],
      }
    end
  end

  def time_step!
    @moons.combination(2).each do |a, b|
      N.times do |i|
        cmp = (a[:pos][i] <=> b[:pos][i])
        a[:vel][i] -= cmp
        b[:vel][i] += cmp
      end
    end
    @moons.each do |a|
      N.times do |i|
        a[:pos][i] += a[:vel][i]
      end
    end
  end

  def total_energy
    @moons.sum do |a|
      a[:pos].sum(&:abs) * a[:vel].sum(&:abs)
    end
  end

  def part1(steps = 1000)
    steps.times { time_step! }
    total_energy
  end

  def find_cycles
    viewed = Array.new(N) { {} }
    cycles = [nil] * N
    steps = 0

    loop do
      N.times do |i|
        next unless cycles[i].nil?

        key = @moons.flat_map { |m| [m[:pos][i], m[:vel][i]] }
        if viewed[i][key]
          cycles[i] = steps
        else
          viewed[i][key] = true
        end
      end
      return cycles unless cycles.any?(&:nil?)

      time_step!
      steps += 1
    end
  end

  def part2
    find_cycles.reduce(&:lcm)
  end
end
