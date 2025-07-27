# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Aplenty
  extend T::Sig

  class Attribute < T::Enum
    enums do
      X = new
      M = new
      A = new
      S = new
    end
  end

  class Op < T::Enum
    enums do
      Gt = new('>')
      Lt = new('<')
      True = new
    end
  end

  class Step < T::Struct
    extend T::Sig

    const :attribute, T.nilable(Attribute)
    const :op, Op
    const :threshold, T.nilable(Integer)
    const :action, String

    sig { params(input: String).returns(Step) }
    def self.parse(input)
      condition, action = input.split(':')
      condition = T.must(condition)
      return new(op: Op::True, action: condition) if action.nil?

      new(
        attribute: Attribute.deserialize(condition[0]),
        op: Op.deserialize(condition[1]),
        threshold: condition[2..].to_i,
        action: action,
      )
    end

    sig { params(item: Item).returns(T::Boolean) }
    def valid?(item)
      item_value = case attribute
                   when Attribute::X then item.x
                   when Attribute::M then item.m
                   when Attribute::A then item.a
                   when Attribute::S then item.s
                   end

      case op
      when Op::True then true
      when Op::Gt then T.must(item_value) > T.must(threshold)
      when Op::Lt then T.must(item_value) < T.must(threshold)
      end
    end

    sig { returns(Range) }
    def range
      case op
      when Op::True then Range.new(min: 1, max: 4000)
      when Op::Gt then Range.new(min: T.must(threshold) + 1, max: 4000)
      when Op::Lt then Range.new(min: 1, max: T.must(threshold) - 1)
      end
    end

    sig { returns(Range) }
    def out_of_range
      case op
      when Op::True then Range.new(min: 1, max: 4000)
      when Op::Gt then Range.new(min: 1, max: T.must(threshold))
      when Op::Lt then Range.new(min: T.must(threshold), max: 4000)
      end
    end
  end

  class Workflow < T::Struct
    extend T::Sig

    const :name, String
    const :steps, T::Array[Step]

    sig { params(input: String).returns(Workflow) }
    def self.parse(input)
      name, steps = input.split('{')
      steps = T.must(T.must(steps)[...-1]).split(',')
      steps = steps.map { Step.parse(_1) }
      new(name: T.must(name), steps: steps)
    end

    sig { params(item: Item).returns(String) }
    def action(item)
      steps.each do |step|
        return step.action if step.valid?(item)
      end

      raise
    end

    sig { params(workflows: T::Hash[String, Workflow]).returns(T::Array[RangeSet]) }
    def accepted_rangesets(workflows)
      result = []
      current = RangeSet.new(
        x_range: Range.new(min: 1, max: 4000),
        m_range: Range.new(min: 1, max: 4000),
        a_range: Range.new(min: 1, max: 4000),
        s_range: Range.new(min: 1, max: 4000),
      )

      steps.each do |step|
        case step.action
        when 'A'
          child = current.dup.merge(step.attribute, step.range)
          result << child unless child.empty?
        when 'R' then nil
        else
          children = T.must(workflows[step.action]).accepted_rangesets(workflows)
          children.each do |rangeset|
            rangeset = current.dup.merge_set(rangeset).merge(step.attribute, step.range)
            result << rangeset unless rangeset.empty?
          end
        end

        next if step.attribute.nil?

        current = current.dup.merge(T.must(step.attribute), step.out_of_range)
        break if current.empty?
      end

      result
    end
  end

  class Item < T::Struct
    extend T::Sig

    const :x, Integer
    const :m, Integer
    const :a, Integer
    const :s, Integer

    sig { params(input: String).returns(Item) }
    def self.parse(input)
      input = T.must(input[1...-1]).split(',')
      x, m, a, s = input.map { _1.split('=')[1].to_i }
      new(x: T.must(x), m: T.must(m), a: T.must(a), s: T.must(s))
    end

    sig { returns(Integer) }
    def total
      x + m + a + s
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    workflows, items = input.split("\n\n")
    @workflows = T.let({}, T::Hash[String, Workflow])

    T.must(workflows).split("\n").each do |workflow|
      workflow = Workflow.parse(workflow)
      @workflows[workflow.name] = workflow
    end

    @items = T.let(T.must(items).split("\n").map { Item.parse(_1) }, T::Array[Item])
  end

  sig { params(item: Item).returns(T::Boolean) }
  def accepted?(item)
    outcome = 'in'
    loop do
      outcome = T.must(@workflows[outcome]).action(item)

      return true if outcome == 'A'
      return false if outcome == 'R'
    end
  end

  sig { returns(Integer) }
  def part1
    @items.sum { accepted?(_1) ? _1.total : 0 }
  end

  class Range < T::Struct
    extend T::Sig

    prop :min, Integer
    prop :max, Integer

    sig { params(other: Range).void }
    def merge(other)
      self.max = other.max if other.max < max
      self.min = other.min if other.min > min
    end

    sig { returns(T::Boolean) }
    def empty?
      min > max
    end

    sig { returns(Integer) }
    def size
      max - min + 1
    end

    sig { returns(Range) }
    def dup
      self.class.new(min: min, max: max)
    end
  end

  class RangeSet < T::Struct
    extend T::Sig

    const :x_range, Range
    const :m_range, Range
    const :a_range, Range
    const :s_range, Range

    sig { params(attribute: T.nilable(Attribute), other: Range).returns(RangeSet) }
    def merge(attribute, other)
      case attribute
      when Attribute::X then x_range.merge(other)
      when Attribute::M then m_range.merge(other)
      when Attribute::A then a_range.merge(other)
      when Attribute::S then s_range.merge(other)
      end

      self
    end

    sig { params(other: RangeSet).returns(RangeSet) }
    def merge_set(other)
      x_range.merge(other.x_range)
      m_range.merge(other.m_range)
      a_range.merge(other.a_range)
      s_range.merge(other.s_range)

      self
    end

    sig { returns(RangeSet) }
    def dup
      self.class.new(
        x_range: x_range.dup,
        m_range: m_range.dup,
        a_range: a_range.dup,
        s_range: s_range.dup,
      )
    end

    sig { returns(Integer) }
    def size
      x_range.size * m_range.size * a_range.size * s_range.size
    end

    sig { returns(T::Boolean) }
    def empty?
      x_range.empty? || m_range.empty? || a_range.empty? || s_range.empty?
    end
  end

  sig { params(start: String).returns(Integer) }
  def part2(start = 'in')
    workflow = T.must(@workflows[start])
    workflow.accepted_rangesets(@workflows).sum(&:size)
  end
end
