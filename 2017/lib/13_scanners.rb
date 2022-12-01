# frozen_string_literal: true

class Scanners
  def initialize(input)
    @input = input
    init!
  end

  def init!
    @scanner_configs = {}
    @scanner_positions = {}
    @input.strip.each_line do |l|
      depth, range = l.split(': ').map(&:to_i)
      @scanner_configs[depth] = range
      @scanner_positions[depth] = { dir: :down, pos: 0 }
    end
    @position = -1
    @severity = 0
    @caught = false
  end

  def run_step!
    @position += 1

    if @scanner_positions[@position] && @scanner_positions[@position][:pos] == 0
      @caught = true
      @severity += @position * @scanner_configs[@position]
    end

    @scanner_positions.each do |k, v|
      v[:pos] += v[:dir] == :down ? 1 : -1
      v[:dir] = :down if v[:pos] == 0
      v[:dir] = :up if v[:pos] == @scanner_configs[k] - 1
    end
  end

  def part1
    run_step! while @position <= @scanner_configs.keys.max
    @severity
  end

  def part2
    # Let's do math
    reverse_scanners = Hash.new { |h, k| h[k] = [] }
    @scanner_configs.each { |k, v| reverse_scanners[v] << k }
    mod = 1
    allowed = [0]
    reverse_scanners.each do |depth, indices|
      period = 2 * (depth - 1)
      new_mod = mod.lcm(period)
      mult = new_mod / mod
      allowed = allowed.flat_map { |a| (0...mult).map { |k| a + (k * mod) } }
      indices.each do |i|
        allowed.reject! { |k| (k - i) % period == 0 }
      end
      mod = new_mod
    end
    mod - allowed.max
  end

  def part2_fail
    # Way too slow
    offset = 0
    initial_scanners = @scanner_positions
    loop do
      init!
      @scanner_positions = initial_scanners.transform_values(&:dup)
      @position = -1
      run_step!
      initial_scanners = @scanner_positions.transform_values(&:dup)
      while @position <= @scanner_configs.keys.max
        break if @caught

        run_step!
      end
      break unless @caught

      offset += 1
    end
    offset
  end
end
