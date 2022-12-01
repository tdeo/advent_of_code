# frozen_string_literal: true

class ReindeerOlympics
  def initialize(input)
    @reindeers = {}
    input.strip.each_line do |l|
      l =~ %r{^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.$}
      @reindeers[$1] = { speed: $2.to_i, duration: $3.to_i, rest: $4.to_i, score: 0 }
    end
  end

  def distance(deer, duration)
    cycles = duration / (deer[:duration] + deer[:rest])
    remainder = duration % (deer[:duration] + deer[:rest])
    ((cycles * deer[:duration]) + [remainder, deer[:duration]].min) * deer[:speed]
  end

  def part1(duration = 2503)
    @reindeers.each_value.map do |deer|
      distance(deer, duration)
    end.max
  end

  def part2(duration = 2503)
    (1..duration).each do |i|
      winners = []
      best_dist = 0
      @reindeers.each_value do |deer|
        d = distance(deer, i)
        if d == best_dist
          winners << deer
        elsif d > best_dist
          winners = [deer]
          best_dist = d
        end
      end
      winners.each { |w| w[:score] += 1 }
    end
    @reindeers.each_value.map { |r| r[:score] }.max
  end
end
