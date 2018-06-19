class ScienceForHungryPeople
  def initialize(input)
    @ingredients = []
    input.strip.each_line do |l|
      l =~ /^(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)$/
      @ingredients << { name: $1, capacity: $2.to_i, durability: $3.to_i, flavor: $4.to_i, texture: $5.to_i, calories: $6.to_i }
    end
  end

  def score(amounts)
    %i(capacity durability flavor texture).map do |cat|
      [@ingredients.map { |i| i[cat] }.zip(amounts).sum { |a, b| a * b }, 0].max
    end.reduce(1, :*)
  end

  def combinations(n, sum)
    return [[sum]] if n == 1
    (0..sum).flat_map do |i|
      combinations(n - 1, sum - i).map { |e| e << i }
    end
  end

  def calories(amounts)
    @ingredients.zip(amounts).sum { |i, a| i[:calories] * a }
  end

  def part1
    best = 0
    combinations(@ingredients.size, 100).each do |amounts|
      s = score(amounts)
      best = [best, s].max
    end
    best
  end

  def part2
    best = 0
    combinations(@ingredients.size, 100).each do |amounts|
      next unless calories(amounts) == 500
      s = score(amounts)
      best = [best, s].max
    end
    best
  end
end
