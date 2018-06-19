class NoSuchThingAsTooMuch
  def initialize(input)
    @containers = input.split("\n").map(&:to_i)
  end

  def part1(target = 150)
    valid = 0
    (0...2**@containers.size).each do |i|
      total = @containers.each_with_index.sum do |c, j|
        c * i[j]
      end
      valid += 1 if total == target
    end
    valid
  end

  def part2(target = 150)
    valids = []
    (0...2**@containers.size).each do |i|
      total = @containers.each_with_index.sum do |c, j|
        c * i[j]
      end
      valids << i.to_s(2).chars.map(&:to_i).reduce(:+) if total == target
    end
    valids.count { |e| e == valids.min }
  end
end
