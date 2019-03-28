require_relative '19_go_with_the_flow'

class ChronalConversion < GoWithTheFlow
  def initialize(input)
    super
  end

  def round!
    super
  end

  def part1
    # The halting condition of the program is r? == r0 on instruction 28
    idx = @instructions[28][1..2].find { |e| e != 0 }
    while @ptr >= 0 && @ptr < @instructions.size
      return @regs[idx] if @ptr == 28
      round!
    end
  end

  def n(r4)
    r1 = r4 | 65536

    r4 = @instructions[7][1]

    while r1 > 0
      r4 += (r1 & 255)
      r4 *= 65899
      r4 &= 16777215
      r1 /= 256
    end
    r4
  end

  def part2
    # it's again all about decompiling:
    # r4 = 123
    # r4 = r4 & 456
    # r4 = (r4 == 72)

    # exit 1 if r4 != 72 # End initialization
    # r4 = 0
    # while true
    #   r1 = r4 | 65536
    #   r4 = 2024736 # this is a constant depending on input
    #   while r1 > 0
    #     r4 += (r1 & 255)
    #     r4 *= 65899
    #     r4 &= 16777215
    #     r1 /= 256
    #   end
    #   exit 0 if r4 == r0
    # end

    r4 = 7129803
    prev = r4
    viewed = { r4 => true }
    while true
      r4 = n(r4)
      return prev if viewed[r4]
      prev = r4
      viewed[r4] = true
    end
  end
end
