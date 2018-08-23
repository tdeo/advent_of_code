require 'digest'

class Chess
  def initialize(input)
    @input = input.strip
    @index = 0
  end

  def digest
    Digest::MD5.hexdigest(@input + @index.to_s)
  end

  def next_index!
    while digest[0...5] != '00000'
      @index += 1
    end
  end

  def get_digit!
    next_index!
    char = digest[5]
    @index += 1
    char
  end

  def part1(times = 8)
    times.times.map { get_digit! }.join
  end

  def part2(times = 8)
    password = {}
    while password.size < times
      next_index!
      password[digest[5].to_i] ||= digest[6] if (0...times).map(&:to_s).include?(digest[5])
      @index += 1
    end
    (0...times).map { |i| password[i] }.join
  end
end
