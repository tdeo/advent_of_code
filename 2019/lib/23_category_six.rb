# frozen_string_literal: true

require_relative 'intcode'

class CategorySix
  def initialize(input)
    @input = input
  end

  def part1(n = 50)
    intcodes = Array.new(n) do |i|
      Intcode.new(@input).default!(-1).sendint(i)
    end

    loop do
      intcodes.each_with_index do |intcode, k|
        intcode.sendint(-1) if intcode.stdin.empty? && intcode.instruction == 3
        intcode.run_until_input

        while intcode.output?(3)
          dest, x, y = Array.new(3) { intcode.getint }
          puts "#{k} -> #{dest} :".ljust(20) + "#{x} #{y}" if ENV['DEBUG']
          return y if dest == 255

          intcodes[dest].sendint(x).sendint(y)
        end
      end
    end
  end

  def part2(n = 50)
    intcodes = Array.new(n) do |i|
      Intcode.new(@input).default!(-1).sendint(i)
    end

    last_y = nil
    nat = nil

    loop do
      all_idle = true
      intcodes.each_with_index do |intcode, k|
        intcode_idle = false
        if intcode.stdin.empty? && intcode.instruction == 3
          intcode_idle = true
          intcode.sendint(-1)
        end
        intcode.run_until_input

        while intcode.output?(3)
          intcode_idle = false
          dest, x, y = Array.new(3) { intcode.getint }
          puts "#{k} -> #{dest} :".ljust(20) + "#{x} #{y}" if ENV['DEBUG']
          if dest == 255
            nat = [x, y]
          else
            intcodes[dest].sendint(x).sendint(y)
          end
        end

        all_idle = false if intcode_idle == false
      end

      next unless all_idle

      x, y = nat
      return y if y == last_y

      last_y = y
      intcodes[0].sendint(x).sendint(y)
    end
  end
end
