class ProgramAlarm
  def initialize(input)
    @tape = input.split(',').map(&:to_i)
  end

  def set(i, val)
    @tape[i] = val
    self
  end

  def a
    @tape[@tape[@i + 1]]
  end

  def b
    @tape[@tape[@i + 2]]
  end

  def instruction
    @tape[@i]
  end

  def compute
    case instruction
    when 1
      @tape[@tape[@i + 3]] = a + b
    when 2
      @tape[@tape[@i + 3]] = a * b
    else
      fail "Can\'t perform instruction #{@tape[@i]} at index #{@i}"
    end
  end

  def perform
    return false if @tape[@i] == 99
    compute
    return true
  end

  def part1(test = false)
    @i = 0
    unless test
      @tape[1] = 12
      @tape[2] = 2
    end

    while true do
      puts "#{@i} - #{@tape[@i .. @i+3]}" if ENV['DEBUG']
      out = perform
      break unless (out == true)
      @i += 4
    end
    @tape[0]
  end

  def part2(target = 19690720)
    orig = @tape.dup
    (0..99).each do |i1|
      next if i1 >= @tape.length
      (0..99).each do |i2|
        next if i2 >= @tape.length
        @tape = orig.dup
        @tape[1] = i1
        @tape[2] = i2
        r = part1(true)
        if r == target
          return 100 * i1 + i2
        end
      end
    end
  end
end
