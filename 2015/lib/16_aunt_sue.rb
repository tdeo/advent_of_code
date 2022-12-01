# frozen_string_literal: true

class AuntSue
  def initialize(input)
    @aunts = {}
    input.strip.each_line do |l|
      l =~ /^Sue (\d+): (.*)$/
      @aunts[$1] = $2.split(', ').to_h { |t| t.split(': ') }
    end
    @result = {
      'children' => '3',
      'cats' => '7',
      'samoyeds' => '2',
      'pomeranians' => '3',
      'akitas' => '0',
      'vizslas' => '0',
      'goldfish' => '5',
      'trees' => '3',
      'cars' => '2',
      'perfumes' => '1',
    }
  end

  def part1
    @aunts.find { |_, v| @result.merge(v) == @result }.first
  end

  EXACT_NUMBERS = %w[children samoyeds akitas vizslas cars perfumes].freeze

  def part2
    @aunts.find do |_, v|
      EXACT_NUMBERS.all? { |k| v[k].nil? || v[k] == @result[k] } &&
        (v['cats'].nil? || v['cats'] > @result['cats']) &&
        (v['trees'].nil? || v['trees'] > @result['trees']) &&
        (v['pomeranians'].nil? || v['pomeranians'] < @result['pomeranians']) &&
        (v['goldfish'].nil? || v['goldfish'] < @result['goldfish'])
    end.first
  end
end
