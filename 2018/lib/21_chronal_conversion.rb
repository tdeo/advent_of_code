# frozen_string_literal: true

require_relative '19_go_with_the_flow'

class ChronalConversion < GoWithTheFlow
  def part1
    # The halting condition of the program is r4 == r0 on instruction 28
    while @ptr >= 0 && @ptr < @instructions.size
      return @regs[4] if @ptr == 28

      round!
    end
  end

  def n(r4)
    r1 = r4 | 65_536

    r4 = 2_024_736

    while r1 > 0
      r4 += (r1 & 255)
      r4 *= 65_899
      r4 &= 16_777_215
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
    #   r4 = 2024736
    #   while r1 > 0
    #     r4 += (r1 & 255)
    #     r4 *= 65899
    #     r4 &= 16777215
    #     r1 /= 256
    #   end
    #   exit 0 if r4 == r0
    # end

    r4 = 7_129_803
    prev = r4
    viewed = { r4 => true }
    loop do
      r4 = n(r4)
      return prev if viewed[r4]

      prev = r4
      viewed[r4] = true
    end
  end
end
