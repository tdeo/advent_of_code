class AdapterArray
  def initialize(input)
    @input = input
    @adapters = @input.each_line.map(&:to_i)
  end

  def part1
    @adapters.sort!

    @adapters.unshift(0)
    @adapters << @adapters[-1] + 3

    count = Hash.new(0)
    @adapters.each_cons(2) { |a, b| count[b - a] += 1 }

    count[1] * count[3]
  end

  def part2
    @adapters.sort!

    options = Hash.new(0)
    options[0] = 1

    @adapters.each do |a|
      options[a] = options[a - 1] + options[a - 2] + options[a - 3]
    end

    options[@adapters.last]
  end
end
