# frozen_string_literal: true

class IterateWithCycle
  def initialize(initial = 0, &succ)
    @initial = initial
    @current = initial
    @succ = succ
  end

  def iterate(times)
    v = {}
    v[@current] = 0
    i = 0
    cycle_length = nil
    while i < times
      i += 1
      @current = @succ.call(@current)
      if v[@current] && !cycle_length
        cycle_length = i - v[@current]
        times = i + ((times - i) % cycle_length)
      end
      v[@current] ||= i
    end
    @current
  end
end
