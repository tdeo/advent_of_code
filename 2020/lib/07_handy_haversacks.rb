# frozen_string_literal: true

class HandyHaversacks
  def initialize(input)
    @input = input
    @contains = Hash.new { |h, k| h[k] = [] }
    @contained = Hash.new { |h, k| h[k] = [] }
    @input.each_line do |line|
      container, contained = line.split('contain')

      container = container.gsub(/\bbag.*/, '').strip
      containees = contained.split(',').map do |item|
        [
          item.gsub(/\bbag.*/, '').gsub(/.*\d+/, '').strip,
          item.strip.to_i,
        ]
      end

      @contains[container] = containees
      containees.each { @contained[item[0]] << container }
    end
  end

  def part1
    target = 'shiny gold'
    queue = [target]
    visited = {}

    until queue.empty?
      a = queue.pop

      @contained[a].each do |b|
        next if visited.key?(b)

        visited[b] = true
        queue << b
      end
    end

    visited.size
  end

  def total_contained(bag)
    @cache_total ||= {}
    return @cache_total[bag] if @cache_total.key?(bag)

    result = 0
    @contains[bag].each do |other, count|
      result += count * (total_contained(other) + 1)
    end

    @cache_total[bag] = result
  end

  def part2
    total_contained('shiny gold')
  end
end
