# typed: strict
# frozen_string_literal: true

require 'openssl'
require 'sorbet-runtime'

class Chess
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = T.let(input.strip, String)
    @index = T.let(0, Integer)
    @md5 = T.let(OpenSSL::Digest.new('MD5'), OpenSSL::Digest)
  end

  sig { returns(String) }
  def hash
    @md5 << @input << @index.to_s
    @md5.digest!
  end

  sig { returns(String) }
  def digest
    @md5 << @input << @index.to_s
    @md5.hexdigest!
  end

  sig { void }
  def next_index!
    loop do
      h = hash
      break if h.getbyte(0) == 0 && h.getbyte(1) == 0 && T.must(h.getbyte(2)) < 0x10

      @index += 1
    end
  end

  sig { returns(String) }
  def next_digit!
    next_index!
    char = T.must(digest[5])
    @index += 1
    char
  end

  sig { params(times: Integer).returns(String) }
  def part1(times = 8)
    Array.new(times) { next_digit! }.join
  end

  sig { params(times: Integer).returns(String) }
  def part2(times = 8)
    password = {}
    while password.size < times
      next_index!
      dig = digest
      pos = T.must(dig[5]).to_i(16)
      password[pos] ||= dig[6] if pos < times
      @index += 1
    end
    (0...times).map { |i| password[i] }.join
  end
end
