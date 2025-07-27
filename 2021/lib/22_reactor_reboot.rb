# frozen_string_literal: true

require 'bigdecimal'

class ReactorReboot
  INST_RE = /^(on|off) x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)$/

  class Step
    attr_accessor :x, :y, :z, :on

    def intersection(other)
      Step.new.tap do |inter|
        inter.x = [x, other.x].map(&:begin).max..[x, other.x].map(&:end).min
        inter.y = [y, other.y].map(&:begin).max..[y, other.y].map(&:end).min
        inter.z = [z, other.z].map(&:begin).max..[z, other.z].map(&:end).min
      end
    end

    def size
      [x, y, z].map(&:size).reduce(:*)
    end

    def multiplier
      on ? 1 : -1
    end

    def signed_size
      size * multiplier
    end
  end

  class Reactor
    attr_reader :steps

    def initialize
      @steps = []
    end

    def add_step(step)
      steps_to_add = []
      @steps.each do |current_step|
        intersection = step.intersection(current_step)
        intersection.on = !current_step.on
        steps_to_add << intersection unless intersection.signed_size == 0
      end
      steps_to_add << step if step.on
      @steps.push(*steps_to_add)
    end
  end

  def initialize(input)
    @input = input
    @instructions = input.split("\n")
    @steps = @instructions.map do |ins|
      matchdata = INST_RE.match(ins)
      xmin, xmax, ymin, ymax, zmin, zmax = matchdata[2..7].map(&:to_i)
      Step.new.tap do |step|
        step.on = matchdata[1] == 'on'
        step.x = xmin..xmax
        step.y = ymin..ymax
        step.z = zmin..zmax
      end
    end
  end

  def part1
    reactor = Reactor.new
    @steps.each { reactor.add_step(_1) }

    bounded = Step.new.tap do |step|
      step.x = -50..50
      step.y = -50..50
      step.z = -50..50
    end

    reactor.steps.sum do |step|
      limited = step.intersection(bounded)
      limited.on = step.on
      limited.signed_size
    end
  end

  def part2
    reactor = Reactor.new
    @steps.each { reactor.add_step(_1) }

    reactor.steps.sum(&:signed_size)
  end
end
