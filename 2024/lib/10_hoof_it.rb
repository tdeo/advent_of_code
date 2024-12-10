# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class HoofIt
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(@input.lines(chomp: true).map { _1.each_char.map(&:to_i) }, T::Array[T::Array[Integer]])
  end

  sig { params(from: [Integer, Integer]).returns(T::Hash[[Integer, Integer], Integer]) }
  def reachable(from)
    q = [from]
    count = T.let({ from => 1 }, T::Hash[[Integer, Integer], Integer])

    queue = T.let(Kernel.lambda { |el, w|
      if count[el]
        count[el] = count[el].to_i + w
        break
      end

      q << el
      count[el] = w
    }, T.proc.params(arg0: [Integer, Integer], arg1: Integer).void,)

    loop do
      current = q.shift
      break if current.nil?

      i, j = current
      height = T.must(@map.dig(i, j))
      weight = count[current].to_i
      count.delete(current) unless height == 9

      queue.call([i + 1, j], weight) if @map.dig(i + 1, j) == height + 1
      queue.call([i, j + 1], weight) if @map.dig(i, j + 1) == height + 1
      queue.call([i - 1, j], weight) if i > 0 && @map.dig(i - 1, j) == height + 1
      queue.call([i, j - 1], weight) if j > 0 && @map.dig(i, j - 1) == height + 1
    end
    count
  end

  sig { returns(Integer) }
  def part1
    @map.each_with_index.sum do |row, i|
      row.each_with_index.sum do |h, j|
        next 0 unless h == 0

        reachable([i, j]).size
      end
    end
  end

  sig { returns(Integer) }
  def part2
    @map.each_with_index.sum do |row, i|
      row.each_with_index.sum do |h, j|
        next 0 unless h == 0

        reachable([i, j]).values.sum
      end
    end
  end
end
