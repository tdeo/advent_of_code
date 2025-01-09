# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/priority_queue'

class ProboscideaVolcanium
  extend T::Sig

  class Valve < T::Struct
    prop :name, String
    prop :debit, Integer
    prop :neighbours, T::Array[String]
    prop :bit, Integer, default: 31
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @valves = T.let({}, T::Hash[String, Valve])
    @input.each_line(chomp: true) do |line|
      m = T.must(/^Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.*)$/.match(line))
      @valves[T.must(m[1])] = Valve.new(name: T.must(m[1]), debit: m[2].to_i, neighbours: T.must(m[3]).split(', '))
    end
    @distances = T.let({}, T::Hash[String, T::Hash[String, Integer]])
    @valves.each_value do |v|
      (@distances[v.name] ||= {})[v.name] = 0
      v.neighbours.each do |n|
        (@distances[v.name] ||= {})[n] = 1
      end
    end
    i = -1
    @valves.each_value { _1.bit = (i += 1) if _1.debit > 0 }
    @valves.each_key do |a|
      @valves.each_key do |b|
        @valves.each_key do |c|
          db = T.must(@distances[b])
          da = T.must(@distances[a])
          next unless db.key?(a) && da.key?(c)

          T.must(@distances[b])[c] = T.must([db[c], T.must(db[a]) + T.must(da[c])].compact.min)
        end
      end
    end
  end

  class State < T::Struct
    extend T::Sig

    prop :pos, String
    prop :timeleft, Integer
    prop :opened, Integer
    prop :valves, T::Hash[String, Valve]
    prop :released, Integer
    prop :distances, T::Hash[String, T::Hash[String, Integer]]

    sig { returns(Integer) }
    def opened_remaining_flow
      opened_debit * timeleft
    end

    sig { returns(Integer) }
    def opened_debit
      valves.each_value.sum { opened[_1.bit] == 1 ? _1.debit : 0 }
    end

    sig { returns(Integer) }
    def expected
      @expected ||= T.let(released + opened_remaining_flow, T.nilable(Integer))
    end

    sig { returns(Valve) }
    def valve
      T.must(valves[pos])
    end

    sig { returns(T::Array[State]) }
    def neighbours
      return [] if timeleft == 0

      valves.filter_map do |name, v|
        next if opened[v.bit] == 1
        next if name == pos
        next if v.debit == 0

        d = T.must(T.must(distances[pos])[name])
        next if timeleft <= d

        State.new(
          pos: name, valves: valves, distances: distances,
          opened: opened | (1 << v.bit),
          timeleft: timeleft - d - 1,
          released: released + ((d + 1) * opened_debit),
        )
      end
    end
  end

  sig { returns(Integer) }
  def part1
    init = State.new(
      pos: 'AA', valves: @valves, distances: @distances,
      opened: 0, released: 0, timeleft: 30,
    )
    q = T.let([init], T::Array[State])
    best = 0

    until q.empty?
      a = T.must(q.pop)
      best = [a.expected, best].max
      a.neighbours.each { q << _1 }
    end
    best
  end

  sig { returns(Integer) }
  def part2
    scores = T.let({}, T::Hash[Integer, Integer])
    init = State.new(
      pos: 'AA', valves: @valves, distances: @distances,
      opened: 0, released: 0, timeleft: 26,
    )
    q = T.let([init], T::Array[State])

    until q.empty?
      h = T.must(q.pop)
      scores[h.opened] = [scores[h.opened] || 0, h.expected].max
      h.neighbours.each { q << _1 }
    end

    best = T.let(0, Integer)
    scores.keys.combination(2) do |a, b|
      a = T.must(a)
      b = T.must(b)
      best = [best, T.must(scores[a]) + T.must(scores[b])].max if (a & b) == 0
    end
    best
  end
end

require 'byebug'
