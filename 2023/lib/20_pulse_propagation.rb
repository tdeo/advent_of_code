# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class PulsePropagation
  extend T::Sig

  class Type < T::Enum
    enums do
      Broadcast = new
      FlipFlop = new
      Conjunction = new
    end
  end

  class Pulse < T::Struct
    const :from, String
    const :value, T::Boolean
    const :to, String
  end

  class Module < T::Struct
    extend T::Sig

    const :modules, T::Hash[String, Module]
    const :name, String
    const :destinations, T::Array[String]
    const :type, Type
    prop :flipflop_state, T::Boolean, default: false
    prop :conjunction_state, T::Hash[String, T::Boolean], default: {}

    sig { params(pulse: Pulse).returns(T::Array[Pulse]) }
    def process(pulse)
      case type
      when Type::Broadcast
        destinations.map { Pulse.new(from: name, to: _1, value: pulse.value) }
      when Type::FlipFlop
        if pulse.value == false
          self.flipflop_state = !flipflop_state
          destinations.map { Pulse.new(from: name, to: _1, value: flipflop_state) }
        else
          []
        end
      when Type::Conjunction
        conjunction_state[pulse.from] = pulse.value
        destinations.map { Pulse.new(from: name, to: _1, value: !conjunction_state.each_value.all?) }
      end
    end

    sig { params(input: String, modules: T::Hash[String, Module]).returns(Module) }
    def self.parse(input, modules:)
      name, destinations = input.split(' -> ')
      name = T.must(name)
      destinations = T.must(destinations).split(', ')
      type = if name[0] == '%'
               Type::FlipFlop
             elsif name[0] == '&'
               Type::Conjunction
             elsif name == 'broadcaster'
               Type::Broadcast
             else
               raise
             end
      name = T.must(name[1..]) if name[0] == '%' || name[0] == '&'
      Module.new(name: name, type: type, destinations: destinations, modules: modules)
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @modules = T.let({}, T::Hash[String, Module])
    @input.each_line(chomp: true) do |line|
      mod = Module.parse(line, modules: @modules)
      @modules[mod.name] = mod
    end
    @modules.each_value do |mod|
      mod.destinations.each do |dest|
        next unless @modules[dest]&.type == Type::Conjunction

        T.must(@modules[dest]).conjunction_state[mod.name] = false
      end
    end
    @low_pulses = T.let(0, Integer)
    @high_pulses = T.let(0, Integer)
  end

  sig { void }
  def press_button
    pulse_queue = T.let([], T::Array[Pulse])
    pulse_queue << Pulse.new(from: 'button', to: 'broadcaster', value: false)

    until pulse_queue.empty?
      pulse = T.must(pulse_queue.shift)
      pulse.value ? @high_pulses += 1 : @low_pulses += 1
      pulse_queue.concat(@modules[pulse.to]&.process(pulse) || [])
    end
  end

  sig { returns(T::Boolean) }
  def identical_to_start?
    @modules.values.all? { _1.flipflop_state == false && _1.conjunction_state.each_value.none? }
  end

  sig { params(count: Integer).returns(Integer) }
  def part1(count = 1000)
    done = 0
    while done < count
      press_button
      done += 1

      next unless identical_to_start?

      remaining = count - done
      next if remaining < done

      times = count / done
      done = times * done
      @low_pulses = times * @low_pulses
      @high_pulses = times * @high_pulses
    end
    @low_pulses * @high_pulses
  end

  sig { returns(Integer) }
  def part2
    # Human observation: the thing outputting to 'rx' is a conjuncter
    # and all its input seem to be cyclic so we can detect those cycle
    # lengths and then compute the lcm

    last_conjuncter = @modules.each_value.find { _1.type == Type::Conjunction && _1.destinations.include?('rx') }
    inputs = T.must(last_conjuncter).conjunction_state.keys
    cycle_sizes = inputs.to_h { [_1, 0] }

    i = 0
    loop do
      i += 1

      pulse_queue = T.let([], T::Array[Pulse])
      pulse_queue << Pulse.new(from: 'button', to: 'broadcaster', value: false)

      until pulse_queue.empty?
        pulse = T.must(pulse_queue.shift)
        if pulse.value && cycle_sizes[pulse.from] == 0
          cycle_sizes[pulse.from] = i
          if cycle_sizes.values.all?(&:positive?)
            res = 1
            cycle_sizes.each_value { res = res.lcm(_1) }
            return res
          end
        end
        pulse.value ? @high_pulses += 1 : @low_pulses += 1
        pulse_queue.concat(@modules[pulse.to]&.process(pulse) || [])
      end
    end
  end
end
