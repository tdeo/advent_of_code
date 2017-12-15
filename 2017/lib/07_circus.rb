class Circus
  def initialize(input)
    @programs = input.split("\n").map do |line|
      m = /^([^\s]+) \((\d+)\)( -> (.*))?$/.match(line.strip)
      [
        m[1],
        {
          name: m[1],
          weight: m[2].to_i,
          children: m[4] ? m[4].split(',').map(&:strip) : [],
        }
      ]
    end.to_h
    @weights = {}
  end

  def root
    has_parent = {}
    @programs.each do |prog_name, prog|
      has_parent[prog_name] = false unless has_parent.key?(prog_name)
      prog[:children].each { |c| has_parent[c] = true }
    end

    has_parent.find { |k, v| !v }.first
  end

  def part1
    root
  end

  def weight(program)
    return @weights[program] if @weights.key? program
    @weights[program] = @programs[program][:weight] + @programs[program][:children].map { |c| weight(c) }.reduce(0, :+)
  end

  def compute_weights!
    weight(root)
  end

  def unbalanced?(program)
    @programs[program][:children].map { |c| weight(c) }.uniq.size > 1
  end

  def parent(program)
    @programs.find { |prog_name, prog| prog[:children].include?(program) }
  end

  def part2
    unbalanced = @programs.keys.select { |prog| unbalanced?(prog) }
    highest = unbalanced.find { |u| !unbalanced.include?(parent(u)) }
    child_weights = @programs[highest][:children].map { |c| weight(c) }
    should_be = child_weights.max_by { |w| child_weights.count(w) }
    diff = should_be - child_weights.min_by { |w| child_weights.count(w) }
    culprit = @programs[highest][:children].min_by { |c| child_weights.count(weight(c)) }
    @programs[culprit][:weight] + diff
  end
end
