require 'json'

class JsAbacusFramework
  def initialize(input)
    @input = input.strip
  end

  def part1
    @input.scan(/(-?\d+)/).map { |m| m[0].to_i }.reduce(0, :+)
  end

  def rec_sum(object)
    return 0 if object.is_a?(Hash) && object.values.include?('red')
    return object.each_value.sum { |v| rec_sum(v) } if object.is_a?(Hash)
    return object.sum { |v| rec_sum(v) } if object.is_a?(Array)
    object.is_a?(Integer) ? object : 0
  end

  def part2
    rec_sum(JSON.parse(@input))
  end
end
