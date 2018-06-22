require 'set'

class MedicineForRudolph
  def initialize(input)
    @rules = []
    input.split("\n").each do |l|
      if l =~ /^(\w+) => (\w+)$/
        @rules << [$1, $2]
      end
      @mol = l if l =~ /^\w+$/
    end
  end

  def part1
    possible = Set.new
    @rules.each do |orig, repl|
      i = 0
      while (i = @mol.index(orig, i))
        possible << @mol[0...i].to_s + repl + @mol[i + orig.size..-1].to_s
        i += 1
      end
    end
    possible.size
  end

  def random_move(mol)
    @rules.shuffle.each do |orig, repl|
      i = mol.index(repl)
      next if i.nil?
      mol.sub!(repl, orig)
      return true
    end
    nil
  end

  def solution(mol)
    i = 0
    while random_move(mol)
      i += 1
    end
    mol == 'e' ? i : nil
  end

  def part2
    z = 100.times.map { solution(@mol.dup) }
    z.compact.min
  end
end
