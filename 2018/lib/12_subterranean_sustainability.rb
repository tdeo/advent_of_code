class SubterraneanSustainability
  def initialize(input)
    @rules = Hash.new('.')
    input.each_line do |l|
      if l.include? 'initial state'
        @state = l[/\s+([\.\#]+)$/, 1]
      elsif l.include? '=>'
        @rules[l[/[\.\#]{5}/]] = l[/=> (\.|\#)/, 1]
      end
    end
    @left = 0
  end

  def next_state!
    @state = '....' + @state + '....'
    @left -= 2
    next_state = ''
    (@state.size - 4).times do |i|
      next_state << @rules[@state[i..i + 4]]
    end
    @state = next_state

    r = @state.slice!(/^\.*/)
    @left += r.size
    @state.slice!(/\.*$/)
  end

  def print!
    puts "#{@left} #{@state}"
  end

  def pot_sum
    s = 0
    @state.each_char.each_with_index do |c, i|
      s += (i + @left) if c == '#'
    end
    s
  end

  def part1
    20.times { next_state! }
    pot_sum
  end

  def part2
    before = nil
    runs = 0
    while true
      before = @state
      runs += 1
      next_state!
      break if before == @state
    end
    score = pot_sum
    next_state!
    score + (5 * 10**10 - runs) * (pot_sum - score)
  end
end
