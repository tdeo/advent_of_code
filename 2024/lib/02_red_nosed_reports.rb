# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class RedNosedReports
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @reports = T.let(@input.lines(chomp: true).map { _1.split.map(&:to_i) }, T::Array[T::Array[Integer]])
  end

  sig { params(report: T::Array[Integer]).returns(T::Boolean) }
  def safe?(report)
    report.each_cons(2).all? do |a, b|
      a = T.must(a)
      b = T.must(b)
      b >= a + 1 && b <= a + 3
    end
  end

  sig { returns(Integer) }
  def part1
    @reports.count { safe?(_1) || safe?(_1.reverse) }
  end

  sig { params(report: T::Array[Integer]).returns(T::Boolean) }
  def safe_with_error?(report)
    idx = (1...report.size - 1).find do |i|
      a = T.must(report[i - 1])
      b = T.must(report[i])
      b < a + 1 || b > a + 3
    end

    return true if idx.nil?

    opt1 = report.dup
    opt1.delete_at(idx - 1)

    opt2 = report.dup
    opt2.delete_at(idx)
    safe?(opt1) || safe?(opt2)
  end

  sig { returns(Integer) }
  def part2
    @reports.count { safe_with_error?(_1) || safe_with_error?(_1.reverse) }
  end
end
