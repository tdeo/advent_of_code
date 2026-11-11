# typed: strict
# frozen_string_literal: true

require 'openssl'
require 'sorbet-runtime'

class StockingStuffer
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @key = T.let(input.strip, String)
    @md5 = T.let(OpenSSL::Digest.new('MD5'), OpenSSL::Digest)
  end

  sig { params(i: Integer).returns(String) }
  def hash(i)
    @md5 << @key << i.to_s
    @md5.digest!
  end

  sig { returns(Integer) }
  def part1
    i = 1
    loop do
      d = hash(i)
      break if d.getbyte(0) == 0 && d.getbyte(1) == 0 && T.must(d.getbyte(2)) < 0x10

      i += 1
    end
    i
  end

  sig { returns(Integer) }
  def part2
    i = 1
    loop do
      d = hash(i)
      break if d.getbyte(0) == 0 && d.getbyte(1) == 0 && d.getbyte(2) == 0

      i += 1
    end
    i
  end
end
