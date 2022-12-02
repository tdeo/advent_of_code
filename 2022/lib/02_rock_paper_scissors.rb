# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class RockPaperScissors
  extend T::Sig

  class Elf < T::Enum
    enums do
      Rock = new('A')
      Paper = new('B')
      Scissors = new('C')
    end
  end

  class Me < T::Enum
    enums do
      Rock = new('X')
      Paper = new('Y')
      Scissors = new('Z')
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = T.let(input, String)
    @rounds = T.let([], T::Array[[Elf, Me]])
    @input.split("\n").each do |line|
      elf, me = line.split
      @rounds << [
        Elf.deserialize(elf),
        Me.deserialize(me),
      ]
    end
  end

  sig { params(elf: Elf, me: Me).returns(T::Boolean) }
  def draw?(elf, me)
    (me == Me::Rock && elf == Elf::Rock) ||
      (me == Me::Paper && elf == Elf::Paper) ||
      (me == Me::Scissors && elf == Elf::Scissors)
  end

  sig { params(elf: Elf, me: Me).returns(T::Boolean) }
  def wins?(elf, me)
    (me == Me::Rock && elf == Elf::Scissors) ||
      (me == Me::Paper && elf == Elf::Rock) ||
      (me == Me::Scissors && elf == Elf::Paper)
  end

  sig { params(elf: Elf, me: Me).returns(Integer) }
  def score(elf, me)
    score = case me
            when Me::Rock then 1
            when Me::Paper then 2
            when Me::Scissors then 3
            else T.absurd(me)
            end

    score += 3 if draw?(elf, me)
    score += 6 if wins?(elf, me)
    score
  end

  sig { returns(Integer) }
  def part1
    total_score = 0
    @rounds.each do |elf, me|
      total_score += score(elf, me)
    end
    total_score
  end

  sig { params(elf: Elf, me: Me).returns(Integer) }
  def score2(elf, me)
    case me
    when Me::Rock
      0 + case elf
          when Elf::Rock then 3
          when Elf::Paper then 1
          when Elf::Scissors then 2
          else T.absurd(elf)
          end
    when Me::Paper
      3 + case elf
          when Elf::Rock then 1
          when Elf::Paper then 2
          when Elf::Scissors then 3
          else T.absurd(elf)
          end
    when Me::Scissors
      6 + case elf
          when Elf::Rock then 2
          when Elf::Paper then 3
          when Elf::Scissors then 1
          else T.absurd(elf)
          end
    else T.absurd(me)
    end
  end

  sig { returns(Integer) }
  def part2
    total_score = 0
    @rounds.each do |elf, me|
      total_score += score2(elf, me)
    end
    total_score
  end
end
