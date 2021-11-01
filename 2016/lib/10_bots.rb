# frozen_string_literal: true

class Bots
  def initialize(input)
    @bots = Hash.new { |h, k| h[k] = [] }
    @config = {}
    @output = {}
    input.strip.each_line { |l| parse(l) }
  end

  def parse(instruction)
    if /^value/.match?(instruction)
      m = /^value (\d+) goes to bot (\d+)$/.match(instruction)
      @bots[m[2].to_i] << m[1].to_i
    else
      m = /^bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)$/.match(instruction)
      @config[m[1].to_i] = {
        low: { type: m[2], num: m[3].to_i },
        high: { type: m[4], num: m[5].to_i },
      }
    end
  end

  def run_step!
    @bots.keys.each do |k| # rubocop:disable Style/HashEachMethods
      next unless @bots[k].size == 2

      low = @bots[k].min
      high = @bots[k].max
      @bots.delete(k)
      if @config[k][:low][:type] == 'bot'
        @bots[@config[k][:low][:num]] << low
      else
        @output[@config[k][:low][:num]] = low
      end
      if @config[k][:high][:type] == 'bot'
        @bots[@config[k][:high][:num]] << high
      else
        @output[@config[k][:high][:num]] = high
      end
      return k if [low, high] == [17, 61]
    end
    nil
  end

  def part1
    loop do
      r = run_step!
      return r unless r.nil?
    end
  end

  def part2
    run_step! until @bots.empty?
    @output[0] * @output[1] * @output[2]
  end
end
