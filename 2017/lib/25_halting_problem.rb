class HaltingProblem
  A = 'A'
  B = 'B'
  C = 'C'
  D = 'D'
  E = 'E'
  F = 'F'

  def initialize(input)
    @steps = 12386363
    @tape = Hash.new { |h, k| h[k] = 0 }
    @cursor = 0
    @state = 'A'
  end

  def current
    @tape[@cursor]
  end

  def write(val)
    @tape[@cursor] = val
  end

  def right
    @cursor += 1
  end

  def left
    @cursor -= 1
  end

  def state(val)
    @state = val
  end

  def stateA
    if current == 0
      write 1
      right
      state B
    else
      write 0
      left
      state E
    end
  end

  def stateB
    if current == 0
      write 1
      left
      state C
    else
      write 0
      right
      state A
    end
  end

  def stateC
    if current == 0
      write 1
      left
      state D
    else
      write 0
      right
      state C
    end
  end

  def stateD
    if current == 0
      write 1
      left
      state E
    else
      write 0
      left
      state F
    end
  end

  def stateE
    if current == 0
      write 1
      left
      state A
    else
      write 1
      left
      state C
    end
  end

  def stateF
    if current == 0
      write 1
      left
      state E
    else
      write 1
      right
      state A
    end
  end

  def ones
    @tape.count { |k, v| v == 1 }
  end

  def part1
    @steps.times do |i|
      __send__(:"state#{@state}")
      puts i if i % 100_000 == 0
    end
    ones
  end
end
