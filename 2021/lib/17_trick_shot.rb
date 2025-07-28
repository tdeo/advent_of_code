# frozen_string_literal: true

class TrickShot
  def initialize(input)
    @input = input
    match_data = /x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)$/.match(input)
    @xmin = match_data[1].to_i
    @xmax = match_data[2].to_i
    @ymin = match_data[3].to_i
    @ymax = match_data[4].to_i
  end

  def trajectory_hits?(vx, vy)
    x = y = 0

    loop do
      return true if x.between?(@xmin, @xmax) && y >= @ymin && y <= @ymax

      return false if x > @xmax
      return false if vx == 0 && x < @xmin
      return false if y < @ymin && vy < 0

      x += vx
      y += vy
      vx -= 1 if vx > 0
      vx += 1 if vx < 0
      vy -= 1
    end
  end

  def compute_ranges
    @vxmin = Math.sqrt(2 * @xmin).floor
    @vxmax = @xmax

    @vymax = if @ymax < 0
               @ymin.abs
             else
               raise 'Unsupported @ymax > 0'
             end
    @vymin = @ymin
  end

  def part1
    compute_ranges
    @vymax.downto(@vymin).each do |vy|
      (@vxmin..@vxmax).each do |vx|
        return (1..vy).sum if trajectory_hits?(vx, vy)
      end
    end
    nil
  end

  def part2
    compute_ranges
    @vymax.downto(@vymin).sum do |vy|
      (@vxmin..@vxmax).count do |vx|
        trajectory_hits?(vx, vy)
      end
    end
  end
end
