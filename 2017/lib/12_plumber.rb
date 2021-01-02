# frozen_string_literal: true

class Plumber
  def initialize(input)
    @pipes = Hash.new { |h, k| h[k] = {} }
    input.strip.each_line do |l|
      a, bs = l.split(' <-> ').map(&:strip)
      @pipes[a.to_i][a.to_i] = true
      bs.split(',').map(&:strip).each do |b|
        @pipes[b.to_i][a.to_i] = true
        @pipes[a.to_i][b.to_i] = true
      end
    end
  end

  def part1
    visited = {}
    queue = [0]
    until queue.empty?
      e = queue.shift
      next if visited[e]

      visited[e] = true
      @pipes[e].each_key do |k|
        queue << k
        @pipes[0][k] = true
      end
    end
    @pipes[0].size
  end

  def part2
    visited = {}
    queue = [0]
    components = 0
    loop do
      until queue.empty?
        e = queue.shift
        next if visited[e]

        visited[e] = true
        @pipes[e].each_key do |k|
          queue << k
          @pipes[0][k] = true
        end
      end
      components += 1
      break if visited.size == @pipes.size

      unknown = @pipes.keys.find { |k| visited[k].nil? }
      queue << unknown
    end
    components
  end
end
