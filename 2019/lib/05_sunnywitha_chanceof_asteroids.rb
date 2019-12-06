class SunnywithaChanceofAsteroids
  def initialize(input)
    @input = input.split(',').map(&:to_i)
  end

  def part1(inputs = [1])
    i = 0
    ret = nil

    while true do
      ins = @input[i] % 100
      a = if (@input[i] / 100) % 10 == 0
        @input[@input[i+1] || 0]
      else
        @input[i+1]
      end
      b = if (@input[i] / 1000) % 10 == 0
        @input[@input[i+2] || 0]
      else
        @input[i+2]
      end

      if ins == 1
        @input[@input[i + 3]] = a + b
        i += 4
      elsif ins == 2
        @input[@input[i + 3]] = a * b
        i += 4
      elsif ins == 3
        @input[@input[i + 1]] = inputs.shift
        i += 2
      elsif ins == 4
        ret = a
        i += 2
      elsif ins == 5
        if a != 0
          i = b
        else
          i += 3
        end
      elsif ins == 6
        if a == 0
          i = b
        else
          i += 3
        end
      elsif ins == 7
        if (a < b)
          @input[@input[i+3]] = 1
        else
          @input[@input[i+3]] = 0
        end
        i += 4
      elsif ins == 8
        if (a == b)
          @input[@input[i+3]] = 1
        else
          @input[@input[i+3]] = 0
        end
        i += 4
      elsif ins == 99
        break
      else
        fail "Unrecognized ins #{ins} at position #{i}"
      end
    end
    ret
  end

  def part2
    part1([5])
  end
end
