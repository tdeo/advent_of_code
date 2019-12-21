require_relative 'intcode'

class SpringdroidAdventure
  def initialize(input)
    @input = input
    @intcode = Intcode.new(input)
  end

  def part1(script = nil)
    @intcode.run_until_input
    while @intcode.has_output?
      print @intcode.getint.chr
    end

    script ||= <<~CODE
      OR D J
      OR A T
      AND B T
      AND C T
      NOT T T
      AND T J
      WALK
    CODE
    script.each_char do |c|
      @intcode.sendint(c.ord)
    end

    @intcode.run
    while @intcode.has_output?
      r = @intcode.getint
      return r if r > 2**8
      print r.chr
    end
  end

  def part2
    script ||= <<~CODE
      OR D J
      OR A T
      AND B T
      AND C T
      NOT T T
      AND T J
      NOT E T
      NOT T T
      OR H T
      AND T J
      RUN
    CODE

    part1(script)
  end
end
