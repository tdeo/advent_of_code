class Knot
  def initialize(input, list_size = 256)
    @list = (0...list_size).to_a
    @current = 0
    @skip_size = 0
    @input = input.strip
  end

  def apply!(length)
    @list = @list[@current..-1] + @list[0...@current]
    @list = (@list[0...length].reverse || []) + (@list[length..-1] || [])
    @list =  @list[-@current..-1] + @list[0...-@current]
    @current = (@current + length + @skip_size) % @list.size
    @skip_size += 1
  end

  def part1
    @lengths = @input.split(',').map(&:strip).map(&:to_i)
    @lengths.each { |l| apply!(l) }
    @list.first(2).reduce(1, :*)
  end

  def part2
    @lengths = @input.chars.map(&:ord) + [17, 31, 73, 47, 23]
    64.times { @lengths.each { |l| apply!(l) } }
    dense = 16.times.map { |i| @list[16 * i...16 * (i + 1)].reduce(0, :^) }
    dense.map { |i| i.to_s(16).rjust(2, '0') }.join
  end
end
