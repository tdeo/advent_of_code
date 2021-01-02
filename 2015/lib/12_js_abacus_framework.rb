# frozen_string_literal: true

require 'json'

class JsAbacusFramework
  def initialize(input)
    @input = input.strip
  end

  def part1
    @input.scan(/(-?\d+)/).sum { |m| m[0].to_i }
  end

  def rec_sum(object)
    return 0 if object.is_a?(Hash) && object.value?('red')
    return object.each_value.sum { |v| rec_sum(v) } if object.is_a?(Hash)
    return object.sum { |v| rec_sum(v) } if object.is_a?(Array)

    object.is_a?(Integer) ? object : 0
  end

  def part2
    rec_sum(JSON.parse(@input))
  end
end
