class SecureContainer
  def initialize(input)
    @input = input
    @s, @e = input.split('-').map(&:to_i)
  end

  def enum
    initial = @s.to_s.chars.map(&:to_i)
    idx = (1...initial.size).find { |i| initial[i] < initial[i-1] }
    unless idx.nil?
      (idx...initial.size).each { |i| initial[i] = initial[idx-1] }
    end

    # final = @e.to_s.chars.map(&:to_i)

    Enumerator.new do |y|
      loop do
        v = initial.join.to_i
        break if v > @e
        y << initial
        idx = initial.rindex { |e| e < 9 }
        if idx.nil?
          initial.unshift(0)
          idx = 0
        end
        initial[idx] += 1
        (idx + 1...initial.size).each do |i|
          initial[i] = initial[i - 1]
        end
      end
    end
  end

  def part1
    c = 0
    enum.each do |pass|
      c += 1 if pass.join =~ /(\d)\1/
    end
    c
  end

  def part2
    c = 0
    enum.each do |pass|
      c += 1 if (pass[0] == pass[1] && pass[1] != pass[2]) ||
        (pass[-3] != pass[-2] && pass[-2] == pass[-1]) ||
        pass.each_cons(4).any? { |a,b,c,d| a != b && b == c && c != d }
    end
    c
  end
end
