class KnightsOfTheDinnerTable
  def initialize(input)
    @happiness = Hash.new { |h, k| h[k] = {} }
    input.strip.each_line do |l|
      l =~ /(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)./
      @happiness[$1][$4] = ($2 == 'gain' ? $3.to_i : -($3.to_i))
    end
  end

  def value(positions)
    positions.each_with_index.sum do |_, i|
      @happiness[positions[i - 1]][positions[i]] +
        @happiness[positions[i]][positions[i - 1]]
    end
  end

  def part1
    people = @happiness.keys
    people[1..-1].permutation.map do |perm|
      value([people[0]] + perm)
    end.max
  end

  def part2
    @happiness.keys.each do |person|
      @happiness['I'][person] = 0
      @happiness[person]['I'] = 0
    end
    part1
  end
end
