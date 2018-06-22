class InfiniteElves
  def initialize(input)
    @target = input.strip.to_i
  end

  def divisor_sum(n)
    i = 2
    sum = 1 + n
    while i * i < n
      if n % i == 0
        sum += i
        sum += n / i
      end
      i += 1
    end
    sum += i if i * i == n
    sum
  end

  def part1
    k = 1
    while divisor_sum(k) * 10 < @target
      k += 1
    end
    k
  end

  def presents_part2(n)
    i = 1
    sum = 0
    while i * i < n && i <= 50
      if n % i == 0
        sum += n / i
        sum += i if n / i <= 50
      end
      i += 1
    end
    sum += i if i * i == n && i <= 50
    sum * 11
  end

  def part2
    k = 1
    while presents_part2(k) < @target
      k += 1
    end
    k
  end
end
