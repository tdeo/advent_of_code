# frozen_string_literal: true

class ChronalCharge
  def initialize(input)
    @serial = input.to_i
    @size = 300
    @power = Hash.new do |h, x|
      raise if x <= 0 || x > @size

      h[x] = Hash.new do |h2, y|
        raise if y <= 0 || y > @size

        pow = (x + 10) * y
        pow += @serial
        pow *= (x + 10)
        pow = (pow / 100) % 10
        pow -= 5
        h2[y] = pow
      end
    end
  end

  def part1
    best = -100
    cell = nil
    (1..@size - 2).each do |i|
      (1..@size - 2).each do |j|
        val = @power[i][j] + @power[i + 1][j] + @power[i + 2][j] +
              @power[i][j + 1] + @power[i + 1][j + 1] + @power[i + 2][j + 1] +
              @power[i][j + 2] + @power[i + 1][j + 2] + @power[i + 2][j + 2]
        if val > best
          best = val
          cell = [i, j]
        end
      end
    end
    cell.join(',')
  end

  def best_subarray(a, l)
    s = 0
    (1..l).each do |i|
      s += a[i]
    end
    best = s
    from = 1

    (1..@size - l).each do |i|
      s += a[i + l] - a[i]
      if s > best
        best = s
        from = i + 1
      end
    end
    [best, from]
  end

  def part2
    best = -10**10
    cell = nil
    (1..@size).each do |l|
      tmp = Hash.new { |h, k| h[k] = 0 }
      (l..@size).each do |r|
        (1..@size).each do |i|
          tmp[i] += @power[i][r]
        end

        max = best_subarray(tmp, r - l + 1)
        if max[0] > best
          best = max[0]
          cell = [max[1], l, r - l + 1]
        end
      end
    end
    cell.join(',')
  end
end
