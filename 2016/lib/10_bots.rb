class Bots
  def initialize(input)
    @bots = Hash.new { |h, k| h[k] = [] }
    @config = {}
    @output = {}
    input.each_line { |l| parse(l) }
  end

  def parse(instruction)
    if instruction =~ /^value/
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
    @bots.keys.each do |k|
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
    end
  end

  def part1
    while true do
      @bots.each { |k, v| return k if v.sort == [17, 61] }
      run_step!
    end
  end

  def part2
    while !@bots.empty? do
      run_step!
    end
    @output[0] * @output[1] * @output[2]
  end
end
