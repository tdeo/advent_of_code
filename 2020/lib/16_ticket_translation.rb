# frozen_string_literal: true

class TicketTranslation
  def initialize(input)
    @input = input

    rules, my_tickets, nearby_tickets = input.split("\n\n")

    @rules = Hash.new { |hash, key| hash[key] = [] }
    rules.each_line do |line|
      key, values = line.split(': ')
      values = values.split(' or ')
      values.each do |range|
        @rules[key] << range.split('-').map(&:to_i)
      end
    end

    @mine = my_tickets.split("\n")[1].split(',').map(&:to_i)
    @nearby = nearby_tickets.split("\n")[1..].map { |line| line.split(',').map(&:to_i) }
  end

  def valid?(value, ranges)
    ranges.any? { |low, high| low <= value && value <= high }
  end

  def valid_ticket?(ticket)
    ticket.all? do |value|
      @rules.values.any? do |ranges|
        valid?(value, ranges)
      end
    end
  end

  def part1
    invalid = 0

    @nearby.each do |ticket|
      ticket.each do |value|
        next if valid?(value, @rules.values.flatten(1))

        invalid += value
      end
    end

    invalid
  end

  def part2(regex = /^departure/)
    options = @rules.keys.to_h { |key| [key, (0...@rules.size).to_a] }

    @nearby.each do |ticket|
      next unless valid_ticket?(ticket)

      ticket.each_with_index do |value, i|
        @rules.each do |key, ranges|
          next if valid?(value, ranges)

          options[key].delete(i)
        end
      end
    end

    propagated = {}
    options.size.times do
      options.each do |key, values|
        next unless values.size == 1
        next if propagated.key?(key)

        propagated[key] = true

        options.each_key do |k2|
          options[k2].delete(values[0]) if k2 != key
        end
      end
    end

    result = 1
    options.each do |key, values|
      next unless key&.match?(regex)
      raise if values.size > 1

      result *= @mine[values[0]]
    end

    result
  end
end
