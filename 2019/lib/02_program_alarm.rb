class ProgramAlarm
  def initialize(input)
    @input = input.split(',').map(&:to_i)
  end

  def part1(test = false)
    i = 0
    unless test
      @input[1] = 12
      @input[2] = 02
    end
    while true do
      if @input[i] == 1
        @input[@input[i + 3]] = @input[@input[i + 1]] + @input[@input[i + 2]]
      elsif @input[i] == 2
        @input[@input[i + 3]] = @input[@input[i + 1]] * @input[@input[i + 2]]
      elsif @input[i] == 99
        break
      else
        fail "Unrecognized ins #{@input[i]} at position #{i}"
      end
      i += 4
    end
    @input[0]
  end

  def part2(target = 19690720)
    orig = @input.dup
    (0..99).each do |i1|
      next if i1 >= @input.length
      (0..99).each do |i2|
        next if i2 >= @input.length
        @input = orig.dup
        @input[1] = i1
        @input[2] = i2
        r = part1(true)
        if r == target
          return 100 * i1 + i2
        end
      end
    end
  end
end
