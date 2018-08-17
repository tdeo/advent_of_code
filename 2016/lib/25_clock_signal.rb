class ClockSignal
  def initialize(input)
  end

  # The code rewritten to ruby gives the following.
  # It can be rewritten that it repeatedly prints the reversed binary
  # representation of a + 7 * 362. The smallest number that's going to work is
  # thus such that a + 7 * 362 is written as alternating 1's and 0's,
  # hence the solution a = "10101010101010".to_i(2) - 7 * 362.
  # Because (7 * 362).to_s(2) = "100111100110"
  def code
    d = a + 7 * 362
    b = c = 0
    while true
      a = d
      while a != 0
        b = a
        a = 0
        while true
          c = 2
          while c != 0
            break if b == 0
            b -= 1
            c -= 1
          end
          break if b == 0
          a += 1
        end
        b = 2 - c
        c = 0
        puts b
      end
    end
  end


  def part1
    "10101010101010".to_i(2) - 7 * 362
  end
end
