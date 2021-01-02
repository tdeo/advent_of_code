# frozen_string_literal: true

class CorporatePolicy
  TRIOS = /(#{'a'.upto('z').each_cons(3).map(&:join).join('|')})/.freeze

  def initialize(input)
    @pass = input.strip
  end

  def next!
    @pass.succ!
    @pass.sub!(/([iol]).*$/, '\1\2')
    return unless @pass.size < 8

    @pass.succ!
    @pass << 'a' * (8 - @pass.size)
  end

  def valid?
    @pass =~ /(.)\1.*([^\1])\2/ && @pass =~ TRIOS && @pass !~ /(iol)/
  end

  def part1
    loop do
      next!
      break if valid?
    end
    @pass
  end

  def part2
    part1
    part1
  end
end
