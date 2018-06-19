class CorporatePolicy
  TRIOS = /(#{'a'.upto('z').each_cons(3).map(&:join).join('|')})/.freeze

  def initialize(input)
    @pass = input.strip
  end

  def next!
    @pass.succ!
    @pass.sub!(/([iol]).*$/, '\1\2')
    if @pass.size < 8
      @pass.succ!
      @pass << 'a' * (8 - @pass.size)
    end
  end

  def valid?
    @pass =~ /(.)\1.*([^\1])\2/ && @pass =~ TRIOS && !(@pass =~ /(iol)/)
  end

  def part1
    begin
      next!
    end until valid?
    @pass
  end

  def part2
    part1
    part1
  end
end
