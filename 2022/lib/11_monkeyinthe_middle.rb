# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MonkeyintheMiddle
  extend T::Sig

  class Monkey < T::Struct
    prop :items, T::Array[Integer]
    prop :operation, [String, Integer], default: ['noop', 0]
    prop :test, Integer, default: 0
    prop :true_target, Integer, default: 0
    prop :false_target, Integer, default: 0
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @inspections = T.let(Hash.new(0), T::Hash[Integer, Integer])
    @monkeys = T.let([], T::Array[Monkey])
    @input.split("\n").each do |line|
      case line
      when /^Monkey (\d+):/
        @monkeys << Monkey.new(items: [])
      when /Starting items: (.*)/
        monkey = T.must(@monkeys.last)
        T.must(T.must(Regexp.last_match)[1]).strip.split(', ').each do |item|
          monkey.items << item.to_i
        end
      when /Operation: new = old ([*+]) (\d+)/
        monkey = T.must(@monkeys.last)
        operator, value = T.must(Regexp.last_match)[1..2]
        monkey.operation[0] = case operator
                              when '*' then 'multiply'
                              when '+' then 'add'
                              else raise "Unrecognized operation in #{line}"
                              end
        monkey.operation[1] = value.to_i
      when /Operation: new = old \* old/
        monkey = T.must(@monkeys.last)
        monkey.operation = ['pow', 2]
      when /Test: divisible by (\d+)/
        monkey = T.must(@monkeys.last)
        monkey.test = T.must(Regexp.last_match)[1].to_i
      when /If true: throw to monkey (\d+)/
        monkey = T.must(@monkeys.last)
        monkey.true_target = T.must(Regexp.last_match)[1].to_i
      when /If false: throw to monkey (\d+)/
        monkey = T.must(@monkeys.last)
        monkey.false_target = T.must(Regexp.last_match)[1].to_i
      when ''
        # noop
      else
        raise "Unrecognized line #{line}"
      end
    end
    @lcm = T.let(1, Integer)
    @monkeys.each do |monkey|
      @lcm = @lcm.lcm(monkey.test)
    end
  end

  sig { params(divide: T::Boolean).void }
  def perform_round!(divide: true)
    @monkeys.each_with_index do |monkey, idx|
      until monkey.items.empty?
        @inspections[idx] = T.must(@inspections[idx]) + 1
        item = T.must(monkey.items.shift)
        item = case monkey.operation[0]
               when 'add' then item + monkey.operation[1]
               when 'pow' then item *= item
               when 'multiply' then item * monkey.operation[1]
               else raise "Unkown operation for #{monkey}"
               end
        if divide
          item /= 3
        else
          item = item % @lcm
        end
        target = item % monkey.test == 0 ? monkey.true_target : monkey.false_target
        T.must(@monkeys[target]).items << item
      end
    end
  end

  sig { returns(Integer) }
  def part1
    20.times { perform_round! }
    a, b = @inspections.values.sort.last(2)
    T.must(a) * T.must(b)
  end

  sig { returns(Integer) }
  def part2
    10_000.times { perform_round!(divide: false) }
    a, b = @inspections.values.sort.last(2)
    T.must(a) * T.must(b)
  end
end
