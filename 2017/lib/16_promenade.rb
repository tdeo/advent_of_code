class Promenade
  def initialize(input, size = 16)
    @moves = input.strip.split(',')
    @pos = size.times.map { |i| ('a'.ord + i).chr }
  end

  def apply!(move)
    case move
    when /^s/
      m = /^s(\d+)$/.match(move)
      size = m[1].to_i
      @pos = @pos[-size..-1] + @pos[0...-size]
    when /^x/
      m = /^x(\d+)\/(\d+)$/.match(move)
      c = @pos[m[1].to_i]
      @pos[m[1].to_i] = @pos[m[2].to_i]
      @pos[m[2].to_i] = c
    when /^p/
      m = /^p(.*)\/(.*)$/.match(move)
      @pos.each_with_index do |k, i|
        if k == m[1]
          @pos[i] = m[2]
        elsif k == m[2]
          @pos[i] = m[1]
        end
      end
    end
  end

  def dance!
    @moves.each { |m| apply!(m) }
  end

  def part1
    dance!
    @pos.join
  end

  def part2
    seen = { @pos.join => 0 }
    todo = 1_000_000_000
    i = 0
    while todo > 0
      i += 1
      dance!
      if seen[@pos.join]
        todo = (todo - i) % (i - seen[@pos.join])
        todo.times { dance! }
        break
      end
      seen[@pos.join] = i
    end
    @pos.join
  end
end
