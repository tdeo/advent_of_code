# frozen_string_literal: true

class AlchemicalReaction
  def initialize(input)
    @input = input.strip
  end

  def part1(delete: {})
    @rest = +''
    (0..(@input.size - 1)).each do |i|
      if delete.key?(@input[i])
        # Do nothing, used for part2
      elsif @rest.empty?
        @rest << @input[i]
      elsif (@input[i].ord - @rest[-1].ord).abs == ('a'.ord - 'A'.ord).abs
        @rest = @rest[0...-1]
      else # rubocop:todo Lint/DuplicateBranch
        @rest << @input[i]
      end
    end
    @rest.size
  end

  def part2
    best = part1
    orig_input = @rest.dup
    @input.downcase.chars.uniq.each do |c|
      @input = orig_input.dup
      best = [best, part1(delete: { c => true, c.upcase => true })].min
    end
    best
  end
end
