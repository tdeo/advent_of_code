# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class NotEnoughMinerals
  extend T::Sig

  class Cost < T::Struct
    prop :ore, Integer
    prop :clay, Integer
    prop :obsidian, Integer
  end

  class Blueprint
    extend T::Sig

    sig { returns(Cost) }
    attr_reader :ore_robot_cost, :clay_robot_cost, :obsidian_robot_cost, :geode_robot_cost

    sig { returns(Integer) }
    attr_reader :max_ore_cost, :max_clay_cost, :max_obsidian_cost

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      robots = T.must(@input.split(': ')[1]).split('. ')

      robot = T.must(robots.find { _1.start_with? 'Each ore robot' })
      @ore_robot_cost = T.let(
        Cost.new(ore: robot[/\d+ ore/].to_i, clay: robot[/\d+ clay/].to_i,
                 obsidian: robot[/\d+ obsidian/].to_i,), Cost,
      )

      robot = T.must(robots.find { _1.start_with? 'Each clay robot' })
      @clay_robot_cost = T.let(
        Cost.new(ore: robot[/\d+ ore/].to_i, clay: robot[/\d+ clay/].to_i,
                 obsidian: robot[/\d+ obsidian/].to_i,), Cost,
      )

      robot = T.must(robots.find { _1.start_with? 'Each obsidian robot' })
      @obsidian_robot_cost = T.let(
        Cost.new(ore: robot[/\d+ ore/].to_i, clay: robot[/\d+ clay/].to_i,
                 obsidian: robot[/\d+ obsidian/].to_i,), Cost,
      )

      robot = T.must(robots.find { _1.start_with? 'Each geode robot' })
      @geode_robot_cost = T.let(
        Cost.new(ore: robot[/\d+ ore/].to_i, clay: robot[/\d+ clay/].to_i,
                 obsidian: robot[/\d+ obsidian/].to_i,), Cost,
      )

      @max_ore_cost = T.let(
        [@clay_robot_cost.ore, @obsidian_robot_cost.ore, @geode_robot_cost.ore].max, Integer,
      )
      @max_clay_cost = T.let(
        [@ore_robot_cost.clay, @obsidian_robot_cost.clay, @geode_robot_cost.clay].max, Integer,
      )
      @max_obsidian_cost = T.let(
        [@ore_robot_cost.obsidian, @clay_robot_cost.obsidian, @geode_robot_cost.obsidian].max, Integer,
      )
    end

    sig { returns(State) }
    def initial_state
      State.new(
        ore: 0,
        clay: 0,
        obsidian: 0,
        geode: 0,
        ore_robots: 1,
        clay_robots: 0,
        obsidian_robots: 0,
        geode_robots: 0,
        time: 0,
        blueprint: self,
      )
    end

    sig { params(max_time: Integer).returns(Integer) }
    def best_geodes(max_time)
      queue = [initial_state]
      best = 0

      loop do
        state = queue.pop
        break if state.nil?
        next if state.optimistic_geode(max_time) <= best

        best = state.geode if state.geode > best

        raise if state.time > max_time

        state.next_states(max_time).each do |next_state|
          raise if next_state.time <= state.time

          queue << next_state
        end
      end

      best
    end
  end

  class State < T::Struct
    extend T::Sig

    prop :ore, Integer
    prop :clay, Integer
    prop :obsidian, Integer
    prop :geode, Integer

    prop :ore_robots, Integer
    prop :clay_robots, Integer
    prop :obsidian_robots, Integer
    prop :geode_robots, Integer

    prop :time, Integer

    prop :blueprint, Blueprint

    sig { params(cost: Cost).returns(T.nilable(Integer)) }
    def purchasable_at(cost)
      return nil if ore_robots == 0 && cost.ore > ore
      return nil if clay_robots == 0 && cost.clay > clay
      return nil if obsidian_robots == 0 && cost.obsidian > obsidian

      delta = [
        (cost.ore - ore).to_f / ore_robots,
        (cost.clay - clay).to_f / clay_robots,
        (cost.obsidian - obsidian).to_f / obsidian_robots,
      ].select(&:finite?).max

      return if delta.nil?

      delta = [delta.ceil + 1, 1].max
      time + delta
    end

    sig { params(max_time: Integer).returns(Integer) }
    def optimistic_geode(max_time)
      geode + ((max_time - time) * geode_robots) + ((max_time - time) * (max_time - time - 1) / 2)
    end

    sig { params(max_time: Integer).returns(T::Array[State]) }
    def next_states(max_time)
      return [] if time == max_time

      states = []

      t = purchasable_at(blueprint.ore_robot_cost)
      if t && t < max_time && ore_robots < blueprint.max_ore_cost
        steps = t - time
        states << State.new(
          time: t,
          ore: ore + (steps * ore_robots) - blueprint.ore_robot_cost.ore,
          clay: clay + (steps * clay_robots) - blueprint.ore_robot_cost.clay,
          obsidian: obsidian + (steps * obsidian_robots) - blueprint.ore_robot_cost.obsidian,
          geode: geode + (steps * geode_robots),
          ore_robots: ore_robots + 1,
          clay_robots: clay_robots,
          obsidian_robots: obsidian_robots,
          geode_robots: geode_robots,
          blueprint: blueprint,
        )
      end

      t = purchasable_at(blueprint.clay_robot_cost)
      if t && t < max_time && clay_robots < blueprint.max_clay_cost
        steps = t - time
        states << State.new(
          time: t,
          ore: ore + (steps * ore_robots) - blueprint.clay_robot_cost.ore,
          clay: clay + (steps * clay_robots) - blueprint.clay_robot_cost.clay,
          obsidian: obsidian + (steps * obsidian_robots) - blueprint.clay_robot_cost.obsidian,
          geode: geode + (steps * geode_robots),
          ore_robots: ore_robots,
          clay_robots: clay_robots + 1,
          obsidian_robots: obsidian_robots,
          geode_robots: geode_robots,
          blueprint: blueprint,
        )
      end

      t = purchasable_at(blueprint.obsidian_robot_cost)
      if t && t < max_time && obsidian_robots < blueprint.max_obsidian_cost
        steps = t - time
        states << State.new(
          time: t,
          ore: ore + (steps * ore_robots) - blueprint.obsidian_robot_cost.ore,
          clay: clay + (steps * clay_robots) - blueprint.obsidian_robot_cost.clay,
          obsidian: obsidian + (steps * obsidian_robots) - blueprint.obsidian_robot_cost.obsidian,
          geode: geode + (steps * geode_robots),
          ore_robots: ore_robots,
          clay_robots: clay_robots,
          obsidian_robots: obsidian_robots + 1,
          geode_robots: geode_robots,
          blueprint: blueprint,
        )
      end

      t = purchasable_at(blueprint.geode_robot_cost)
      if t && t < max_time
        steps = t - time
        states << State.new(
          time: t,
          ore: ore + (steps * ore_robots) - blueprint.geode_robot_cost.ore,
          clay: clay + (steps * clay_robots) - blueprint.geode_robot_cost.clay,
          obsidian: obsidian + (steps * obsidian_robots) - blueprint.geode_robot_cost.obsidian,
          geode: geode + (steps * geode_robots),
          ore_robots: ore_robots,
          clay_robots: clay_robots,
          obsidian_robots: obsidian_robots,
          geode_robots: geode_robots + 1,
          blueprint: blueprint,
        )
      end

      if geode_robots > 0
        steps = max_time - time
        states << State.new(
          time: max_time,
          ore: ore + (steps * ore_robots),
          clay: clay + (steps * clay_robots),
          obsidian: obsidian + (steps * obsidian_robots),
          geode: geode + (steps * geode_robots),
          ore_robots: ore_robots,
          clay_robots: clay_robots,
          obsidian_robots: obsidian_robots,
          geode_robots: geode_robots,
          blueprint: blueprint,
        )
      end

      states
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @blueprints = T.let(input.lines.map { Blueprint.new(_1) }, T::Array[Blueprint])
  end

  sig { params(steps: Integer).returns(Integer) }
  def part1(steps = 24)
    @blueprints.each_with_index.sum { |bp, i| (i + 1) * bp.best_geodes(steps) }
  end

  sig { params(steps: Integer).returns(Integer) }
  def part2(steps = 32)
    @blueprints.first(3).map { _1.best_geodes(steps) }.reduce(1, &:*)
  end
end
