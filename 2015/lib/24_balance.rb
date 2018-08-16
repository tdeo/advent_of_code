class Balance
  def initialize(input)
    @packages = input.split("\n").map(&:to_i).sort
    @total_weight = @packages.sum
  end

  def weight(i) # i is an bitmap integer
    (0...@packages.size).map { |j| i[j] == 1 ? @packages[j] : 0 }.sum
  end

  def groups_weighting(target, from = 0) # assumes it's sorted
    puts "Looking for #{from} - #{target}" if from < 4
    return [[]] if target == 0
    return [] if from >= @packages.size
    return [] if @packages[from] > target
    groups_weighting(target, from + 1) +
      groups_weighting(target - @packages[from], from + 1).map { |g| g.unshift(from) }
  end

  def entanglement(group)
    group.map { |i| @packages[i] }.reduce(1, :*)
  end

  def part1
    groups = groups_weighting(@total_weight / 3)
    puts "Found #{groups.size} groups with target weight"
    groups.sort_by! { |g| [g.size, entanglement(g)] }
    best = groups.find { |a| groups.any? { |b| (a & b).empty? } }
    puts best.join(', ') + " - " + best.map { |i| @packages[i] }.sum.to_s
    entanglement(best)
  end

  def part2
    groups = groups_weighting(@total_weight / 4)
    puts "Found #{groups.size} groups with target weight"
    groups.sort_by! { |g| [g.size, entanglement(g)] }
    best = groups.find do |a|
      groups.any? do |b|
        groups.any? do |c|
          ((a & b) & c).empty?
        end
      end
    end
    puts best.join(', ') + " - " + best.map { |i| @packages[i] }.sum.to_s
    entanglement(best)
  end
end
