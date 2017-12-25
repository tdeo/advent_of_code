class Duet
  def initialize(input)
    @instructions = input.split("\n").map(&:strip)
    @registers = Hash.new { |h, k| h[k] = 0 }
    @last_sound = 0
    @cur_ins = 0
  end

  def value_for(a)
    a =~ /^-?\d+$/ ? a.to_i : @registers[a]
  end

  def apply!
    tokens = @instructions[@cur_ins].split(' ').map(&:strip)
    case tokens[0]
    when 'snd'
      @last_sound = value_for(tokens[1])
    when 'set'
      @registers[tokens[1]] = value_for(tokens[2])
    when 'add'
      @registers[tokens[1]] += value_for(tokens[2])
    when 'mul'
      @registers[tokens[1]] *= value_for(tokens[2])
    when 'mod'
      @registers[tokens[1]] = @registers[tokens[1]] % value_for(tokens[2])
    when 'rcv'
      return @last_sound if value_for(tokens[1]) != 0
    when 'jgz'
      @cur_ins += (value_for(tokens[2]) - 1) if value_for(tokens[1]) > 0
    end
    @cur_ins += 1
    nil
  end

  def part1
    z = nil
    while @cur_ins >= 0 && @cur_ins < @instructions.size
      z = apply!
      return z unless z.nil?
    end
  end

  def value_for2(prog, a)
    a =~ /^-?\d+$/ ? a.to_i : @regs[prog][a]
  end

  def apply2!(prog)
    return 'finished' unless @instructions[@pos[prog]]
    tokens = @instructions[@pos[prog]].split(' ').map(&:strip)
    case tokens[0]
    when 'snd'
      @sent[prog] += 1
      @queues[1 - prog] << value_for2(prog, tokens[1])
    when 'set'
      @regs[prog][tokens[1]] = value_for2(prog, tokens[2])
    when 'add'
      @regs[prog][tokens[1]] += value_for2(prog, tokens[2])
    when 'mul'
      @regs[prog][tokens[1]] *= value_for2(prog, tokens[2])
    when 'mod'
      @regs[prog][tokens[1]] = @regs[prog][tokens[1]] % value_for2(prog, tokens[2])
    when 'rcv'
      return 'blocked' if @queues[prog].empty?
      @regs[prog][tokens[1]] = @queues[prog].shift
    when 'jgz'
      @pos[prog] += (value_for2(prog, tokens[2]) - 1) if value_for2(prog, tokens[1]) > 0
    end
    @pos[prog] += 1
    'going'
  end

  def part2
    @sent = 2.times.map { 0 }
    @regs = 2.times.map { @registers.dup }
    @regs[0]['p'] = 0
    @regs[1]['p'] = 1
    @queues = 2.times.map { [] }
    @pos = 2.times.map { 0 }
    while true
      status = [apply2!(0), apply2!(1)]
      # puts @pos.join(' ')
      # puts status.join(' ')
      break if (status.uniq - %w(finished blocked)).empty?
    end
    @sent[1]
  end
end
