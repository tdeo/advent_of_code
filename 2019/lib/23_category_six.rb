require_relative 'intcode'

class CategorySix
  def initialize(input)
    @input = input
  end

  def part1(n = 50)
    intcodes = n.times.map do |i|
      Intcode.new(@input).set_default(-1).sendint(i)
    end

    while true
      intcodes.each_with_index do |intcode, k|
        if intcode.stdin.empty? && intcode.instruction == 3
          intcode.sendint(-1)
        end
        intcode.run_until_input

        while intcode.has_output?(3)
          dest, x, y = 3.times.map { intcode.getint }
          puts "#{k} -> #{dest} :".ljust(20) + "#{x} #{y}" if ENV['DEBUG']
          return y if dest == 255
          intcodes[dest].sendint(x).sendint(y)
        end
      end
    end
  end

  def part2(n = 50)
    intcodes = n.times.map do |i|
      Intcode.new(@input).set_default(-1).sendint(i)
    end

    last_y = nil
    nat = nil

    while true
      all_idle = true
      intcodes.each_with_index do |intcode, k|
        intcode_idle = false
        if intcode.stdin.empty? && intcode.instruction == 3
          intcode_idle = true
          intcode.sendint(-1)
        end
        intcode.run_until_input

        while intcode.has_output?(3)
          intcode_idle = false
          dest, x, y = 3.times.map { intcode.getint }
          puts "#{k} -> #{dest} :".ljust(20) + "#{x} #{y}" if ENV['DEBUG']
          if dest == 255
            nat = [x, y]
          else
            intcodes[dest].sendint(x).sendint(y)
          end
        end

        if intcode_idle == false
          all_idle = false
        end
      end

      if all_idle
        x, y = nat
        return y if y == last_y
        last_y = y
        intcodes[0].sendint(x).sendint(y)
      end
    end
  end
end
