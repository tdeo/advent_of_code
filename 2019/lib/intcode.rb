class Intcode
  attr_reader :stdout, :stdin, :tape

  def initialize(input)
    @tape = input.split(',').map(&:to_i)
    @i = 0
    @base = 0
    @stdin = []
    @stdout = []
    @finished = false
    @default = nil
    self
  end

  def set_default(val)
    @default = val
    self
  end

  def finished?
    @finished
  end

  def getint
    @stdout.shift
  end

  def has_output?(n = 1)
    @stdout.size >= n
  end

  def sendint(i)
    @stdin << i
    self
  end

  def set(i, val)
    @tape[i] = val
    self
  end

  def get(i)
    @tape[i]
  end

  def a
    if (@tape[@i] / 100) % 10 == 2
      @tape[@base + @tape[@i + 1]]
    elsif (@tape[@i] / 100) % 10 == 1
      @tape[@i + 1]
    else
      @tape[@tape[@i + 1]]
    end.to_i
  end

  def b
    if (@tape[@i] / 1000) % 10 == 2
      @tape[@base + @tape[@i + 2]]
    elsif (@tape[@i] / 1000) % 10 == 1
      @tape[@i + 2]
    else
      @tape[@tape[@i + 2]]
    end.to_i
  end

  def write(di, value)
    case (@tape[@i] / (10*10**di)) % 10
    when 2
      @tape[@base + @tape[@i + di]] = value
    when 0
      @tape[@tape[@i + di]] = value
    else
      fail 'Mode not supported for writing'
    end
  end

  def execute
    case instruction
    when 1
      write(3, a + b)
    when 2
      write(3, a * b)
    when 3
      fail "STDIN empty" if @stdin.empty? && !@default
      write(1, @stdin.shift)
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
      write(3, (a < b) ? 1 : 0)
    when 8
      write(3, (a == b) ? 1 : 0)
    when 9
      @base += a
    else
      fail "Can\'t perform instruction #{@tape[@i]}/#{instruction} at index #{@i}"
    end
  end

  def instruction
    @tape[@i] % 100
  end

  def increment(ins)
    case ins
    when 1, 2, 7, 8
      4
    when 3, 4, 9
      2
    when 5, 6
      0
    else
      fail "Unknwon increment for #{ins}"
    end
  end

  def perform_instruction
    ins = instruction
    if ins == 99
      @finished = true
      return nil
    end
    execute
    @i += increment(ins)
    true
  end

  def run
    while true do
      r = perform_instruction
      break if r.nil?
    end
    self
  end

  def run_until_input
    while true do
      return 'needint' if instruction == 3 && @stdin.empty?
      r = perform_instruction
      return nil if r.nil?
    end
  end
end
