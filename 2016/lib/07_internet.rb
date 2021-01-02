# frozen_string_literal: true

class Internet
  def initialize(input)
    @ips = input.strip.split("\n").map(&:strip)
  end

  def tls?(ip)
    ip !~ /\[[a-z]*([^\[\]])((?!\1).)\2\1/ &&
      ip =~ /([^\[\]])((?!\1).)\2\1/
  end

  def part1
    @ips.count { |ip| tls?(ip) }
  end

  def ssl?(ip)
    outside = ip.gsub(/(\[)[^\]]*(\])/, '\1\2')
    inside = ip.gsub(/(^|\])[^\[]+(\[|$)/, '\1\2')

    outside.chars.each_cons(3) do |a, b, c|
      next if a == b
      next unless a == c
      next if a == '[' || b == '[' || a == ']' || b == ']'
      next unless inside.include?(b + a + b)

      return true
    end
    false
  end

  def part2
    @ips.count { |ip| ssl?(ip) }
  end
end
