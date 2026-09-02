# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MonkeyMath
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @monkeys = T.let({}, T::Hash[String, T.any(Integer, String)])
    @input.each_line(chomp: true) do |line|
      a, b = line.split(': ')
      val = /^\d+$/.match?(b) ? b.to_i : b
      @monkeys[T.must(a)] = T.must(val)
    end
  end

  sig { params(key: String).returns(Integer) }
  def resolve(key)
    monkey = @monkeys.fetch(key)

    @monkeys[key] = case monkey
                    when Integer then monkey
                    when /^\d+$/ then monkey.to_i
                    when %r{^(\w+) (-|\+|\*|/) (\w+)$}
                      lhs, op, rhs = parsed(monkey)
                      lhs = resolve(lhs)
                      rhs = resolve(rhs)
                      case op
                      when '+' then lhs + rhs
                      when '-' then lhs - rhs
                      when '*' then lhs * rhs
                      when '/' then lhs / rhs
                      else
                        raise "Invalid operator: #{op}"
                      end
                    else
                      raise "Invalid monkey string: #{key}: #{monkey}"
                    end
  end

  sig { returns(Integer) }
  def part1
    resolve('root')
  end

  sig { params(expr: String).returns([String, String, String]) }
  def parsed(expr)
    raise unless expr =~ %r{^(\w+) (-|\+|\*|/|=) (\w+)$}

    lhs = T.must(T.must(Regexp.last_match)[1])
    op = T.must(T.must(Regexp.last_match)[2])
    rhs = T.must(T.must(Regexp.last_match)[3])
    [lhs, op, rhs]
  end

  sig { void }
  def bubble_up!
    loop do
      changed = T.let(false, T::Boolean)
      @monkeys.each do |k, expr|
        next unless expr.is_a?(String)
        next unless expr =~ %r{^(\w+) (-|\+|\*|/) (\w+)$}

        lhs, _op, rhs = parsed(expr)
        lhs = @monkeys[lhs]
        rhs = @monkeys[rhs]
        next unless lhs.is_a?(Integer) && rhs.is_a?(Integer)

        changed = true
        op = T.must(Regexp.last_match)[2]
        @monkeys[k] = case op
                      when '+' then lhs + rhs
                      when '-' then lhs - rhs
                      when '*' then lhs * rhs
                      when '/' then lhs / rhs
                      else
                        raise "Invalid operator: #{op}"
                      end
      end
      break unless changed
    end
  end

  sig { params(key: String, value: Integer).returns(Integer) }
  def propagate(key, value)
    return value if key == 'humn'

    monkey = T.must(@monkeys[key])
    raise if monkey.is_a?(Integer)

    lhs, op, rhs = parsed(monkey)

    if @monkeys[lhs].is_a?(Integer)
      lhs = @monkeys[lhs].to_i
      case op
      when '+' then propagate(rhs, value - lhs)
      when '-' then propagate(rhs, lhs - value)
      when '*' then propagate(rhs, value / lhs)
      when '/' then propagate(rhs, lhs / value)
      when '=' then propagate(rhs, lhs)
      else raise
      end
    elsif @monkeys[rhs].is_a?(Integer)
      rhs = @monkeys[rhs].to_i
      case op
      when '+' then propagate(lhs, value - rhs)
      when '-' then propagate(lhs, value + rhs)
      when '*' then propagate(lhs, value / rhs)
      when '/' then propagate(lhs, value * rhs)
      when '=' then propagate(lhs, rhs)
      else raise
      end
    else
      raise
    end
  end

  sig { returns(Integer) }
  def part2
    @monkeys['humn'] = 'not_a_value'
    @monkeys['root'] = @monkeys['root'].to_s.tr('-+*/', '=')
    bubble_up!
    propagate('root', 1)
  end
end
