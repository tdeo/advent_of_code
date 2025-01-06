# frozen_string_literal: true

class MedicineForRudolph
  def initialize(input)
    @rules = []
    input.split("\n").each do |l|
      @rules << [$1, $2] if l =~ /^(\w+) => (\w+)$/
      @mol = l if /^\w+$/.match?(l)
    end
  end

  def part1
    possible = Set.new
    @rules.each do |orig, repl|
      i = 0
      while (i = @mol.index(orig, i))
        possible << (@mol[0...i].to_s + repl + @mol[i + orig.size..].to_s)
        i += 1
      end
    end
    possible.size
  end

  def move(mol)
    @rules.each do |orig, repl|
      i = mol.index(repl)
      next if i.nil?

      mol.sub!(repl, orig)
      return true
    end
    nil
  end

  def solution(mol)
    i = 0
    i += 1 while move(mol)
    mol == 'e' ? i : nil
  end

  def part2
    Array.new(200) do
      @rules.shuffle!
      solution(@mol.dup)
    end.compact.min
  end
end
