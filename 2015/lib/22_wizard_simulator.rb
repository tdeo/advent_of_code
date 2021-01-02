# frozen_string_literal: true

require 'set'

class WizardSimulator
  def initialize(input)
    @input = input
    @spells = [
      { name: :magic_missile, mana_cost: 53 },
      { name: :drain, mana_cost: 73 },
      { name: :shield, mana_cost: 113 },
      { name: :poison, mana_cost: 173 },
      { name: :recharge, mana_cost: 229 },
    ]
    @callbacks = []
    @turn = 0
    @me = {
      mana: 500,
      health: 50,
      armor: 0,
    }
    @history = []
    @total_mana = 0
    @boss = {
      health: input.split("\n").first.split(':').last.strip.to_i,
      damage: input.split("\n").last.split(':').last.strip.to_i,
    }
  end

  def magic_missile
    @boss[:health] -= 4
  end

  def drain
    @boss[:health] -= 2
    @me[:health] += 2
  end

  def shield
    @me[:armor] += 7
    @callbacks << { turn: @turn + 7, effect: :shield_effect }
  end

  def shield_effect
    @me[:armor] -= 7
  end

  def poison
    (1..6).each do |i|
      @callbacks << { turn: @turn + i, effect: :poison_effect }
    end
  end

  def poison_effect
    @boss[:health] -= 3
  end

  def recharge
    (1..5).each do |i|
      @callbacks << { turn: @turn + i, effect: :recharge_effect }
    end
  end

  def recharge_effect
    @me[:mana] += 101
  end

  def win?
    @boss[:health] <= 0
  end

  def boss
    @me[:health] -= [1, @boss[:damage] - @me[:armor]].max
  end

  def available?(spell)
    !@callbacks.map { |e| e[:effect] }.include?(:"#{spell}_effect")
  end

  def next_turn!(hard: false)
    @turn += 1
    if @turn.even? && hard
      @me[:health] -= 1
      @me[:health] -= 1000 if @me[:health] <= 0
    end
    @callbacks.each do |c|
      next unless c[:turn] == @turn

      __send__(c[:effect])
    end
    @callbacks.delete_if { |c| c[:turn] <= @turn }
  end

  def run_action(name)
    spell = @spells.find { |s| s[:name] == name.to_sym }
    @history << name
    @me[:mana] -= spell[:mana_cost] unless spell.nil?
    @total_mana += spell[:mana_cost] unless spell.nil?
    __send__(name.to_sym)
  end

  def available_actions
    return [] if @me[:health] <= 0

    if @turn.odd?
      %i[boss]
    else
      @spells.map { |s| s[:name] if available?(s[:name]) && @me[:mana] >= s[:mana_cost] }.compact
    end
  end

  def dead?
    @me[:health] <= 0
  end

  attr_reader :total_mana

  def part1
    self.class.part1(self)
  end

  def hash
    [@me, @callbacks, @boss].hash
  end

  def self.part1(a)
    queue = [a]
    viewed = Set.new([a.hash])
    until queue.empty?
      a = queue.shift
      return a.total_mana if a.win?

      a.available_actions.each do |act|
        b = Marshal.load(Marshal.dump(a))
        b.run_action(act)
        next if viewed.include?(b.hash)

        viewed << b.hash
        b.next_turn!
        queue.push(b) unless b.dead?
      end
      queue.sort_by!(&:total_mana)
    end
    nil
  end

  def part2
    @me[:health] -= 1 # Hard mode
    self.class.part2(self)
  end

  def self.part2(a)
    queue = [a]
    viewed = Set.new([a.hash])
    until queue.empty?
      a = queue.shift
      return a.total_mana if a.win?

      a.available_actions.each do |act|
        b = Marshal.load(Marshal.dump(a))
        b.run_action(act)
        next if viewed.include?(b.hash)

        viewed << b.hash
        b.next_turn!(hard: true)
        queue.push(b) unless b.dead?
      end
      queue.sort_by!(&:total_mana)
    end
    nil
  end
end
