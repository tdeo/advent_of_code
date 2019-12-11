require_relative '02_program_alarm'

class SunnywithaChanceofAsteroids < ProgramAlarm
  def initialize(input)
    super(input)
    @stdin = []
    @stdout = []
  end

  def sendint(val)
    @stdin << val
    self
  end

  def a
    if (@tape[@i] / 100) % 10 == 1
      @tape[@i + 1]
    else
      super
    end
  end

  def b
    if (@tape[@i] / 1000) % 10 == 1
      @tape[@i + 2]
    else
      super
    end
  end

  def instruction
    @tape[@i] % 100
  end

  def compute
    case instruction
    when 3
      @tape[@tape[@i + 1]] = @stdin.shift
    when 4
      @stdout << a
    when 5
      if a != 0
        @i = b
      else
        @i += 3
      end
    when 6
      if a == 0
        @i = b
      else
        @i += 3
      end
    when 7
      @tape[@tape[@i + 3]] = (a < b) ? 1 : 0
    when 8
      @tape[@tape[@i + 3]] = (a == b) ? 1 : 0
    else
      super
    end
  end

  def increment(instruction)
    case instruction
    when 1, 2, 7, 8
      4
    when 3, 4
      2
    when 5, 6
      0
    else
      fail "Unknwon increment for #{instruction}"
    end
  end

  def perform
    return false if @tape[@i] == 99
    compute
    return true
  end

  def execute
    @i = 0

    while true do
      ins = instruction
      puts "#{@i} - #{@tape}" if ENV['DEBUG']
      out = perform
      break unless (out == true)
      @i += increment(ins)
    end
    @stdout.last
  end

  def part1
    sendint(1).execute
  end

  def part2
    sendint(5).execute
  end
end
