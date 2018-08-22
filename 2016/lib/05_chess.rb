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
      puts @index if @index % 500_000 == 0
    end
  end

  def get_digit!
    next_index!
    char = digest[5]
    puts char + ' for ' + @index.to_s
    @index += 1
    char
  end

  def part1
    8.times.map { get_digit! }.join
  end

  def part2
    password = {}
    while password.size < 8
      next_index!
      password[digest[5].to_i] ||= digest[6] if (0...8).map(&:to_s).include?(digest[5])
      puts password
      @index += 1
    end
    (0...8).map { |i| password[i] }.join
  end
end
