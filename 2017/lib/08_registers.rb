# frozen_string_literal: true

class Registers
  def initialize(input)
    @commands = []
    @vars = Hash.new { |h, k| h[k] = 0 }
    input.strip.each_line { |l| @commands << parse_command(l) }
  end

  def parse_command(command)
    m = /^([a-z]+) (inc|dec) (-?\d+) if ([a-z]+) ([!=<>]+) (-?\d+)$/.match(command.strip)
    raise "Can't parse command: #{command}" if m.nil?

    {
      var: m[1],
      action: m[2] == 'dec' ? :- : :+,
      amount: m[3].to_i,
      cond_var: m[4],
      cond: m[5],
      value: m[6].to_i,
    }
  end

  def met?(command)
    @vars[command[:cond_var]].send(command[:cond], command[:value])
  end

  def run!(command)
    return unless met?(command)

    @vars[command[:var]] = @vars[command[:var]].send(command[:action], command[:amount])
  end

  def run_all!
    @commands.each { |c| run!(c) }
  end

  def part1
    run_all!
    @vars.values.max
  end

  def part2
    max = 0
    @commands.each do |c|
      run!(c)
      max = [max, @vars.values.max].max
    end
    max
  end
end
