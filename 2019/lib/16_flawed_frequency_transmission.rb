# frozen_string_literal: true

class FlawedFrequencyTransmission
  def initialize(input)
    @input = input.strip
    @array = @input.chars.map(&:to_i)
    @pattern = [0, 1, 0, -1]
  end

  def coefficients(idx)
    @memory ||= {}
    @memory[idx] ||= begin
      repeated = @pattern.flat_map { |e| [e] * idx }
      repeated += repeated while repeated.size <= @array.size
      repeated[1..@array.size]
    end
  end

  def phase
    new_array = []
    (0...@array.size).each do |i|
      res = coefficients(i + 1).zip(@array).sum { |a, b| a * b }
      res *= -1 if res < 0
      new_array[i] = res % 10
    end
    @array = new_array
  end

  def part1(times = 100)
    times.times { phase }
    @array.first(8).join
  end

  def part2
    @array *= 10_000
    pos = @input[0...7].to_i
    raise 'Position not in second half' unless pos > 1 + @array.size / 2

    @array = @array[pos..]
    100.times do
      (@array.size - 1).downto(0).each do |i|
        @array[i] = ((@array[i + 1] || 0) + @array[i]) % 10
      end
    end
    @array[0...8].join
  end
end
