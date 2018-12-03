class NoMatterHowYouSliceIt
  def initialize(input)
    @input = input
  end

  def part1
    fabric = Hash.new { |h, k| h[k] = {} }

    count = 0

    @input.each_line do |l|
      m = l.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/)
      _, a, b, c, d = m[1..5].map(&:to_i)

      (a...a + c).each do |i|
        (b...b + d).each do |j|
          fabric[i][j] ||= 0
          count += 1 if fabric[i][j] == 1
          fabric[i][j] += 1
        end
      end
    end

    count
  end

  def part2
    fabric = Hash.new { |h, k| h[k] = {} }

    valid = {}

    @input.each_line do |l|
      m = l.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/)
      id, a, b, c, d = m[1..5].map(&:to_i)
      valid[id] = true

      (a...a + c).each do |i|
        (b...b + d).each do |j|
          if fabric[i][j].nil?
            fabric[i][j] = id
          else
            valid.delete(fabric[i][j])
            valid.delete(id)
          end
        end
      end
    end

    valid.keys.first
  end
end
