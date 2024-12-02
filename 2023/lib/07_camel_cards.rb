# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CamelCards
  extend T::Sig

  class Hand
    extend T::Sig

    sig { params(card: String).returns(Integer) }
    def self.card_value(card)
      case card
      when 'A' then 14
      when 'K' then 13
      when 'Q' then 12
      when 'J' then 11
      when 'T' then 10
      else card.to_i
      end
    end

    sig { returns(T::Array[String]) }
    attr_reader :cards

    sig { returns(Integer) }
    def combination
      counts = @cards.tally.values.sort

      case counts
      when [5] then 7
      when [1, 4] then 6
      when [2, 3] then 5
      when [1, 1, 3] then 4
      when [1, 2, 2] then 3
      when [1, 1, 1, 2] then 2
      else 1
      end
    end

    sig { returns(Integer) }
    attr_reader :bid

    sig { params(input: String).void }
    def initialize(input)
      cards, bid = input.split
      @bid = T.let(bid.to_i, Integer)
      @cards = T.let(T.must(cards).chars, T::Array[String])
    end

    sig { returns(Integer) }
    def card_value
      @cards.map { self.class.card_value(_1).to_s.rjust(2, '0') }.join.to_i
    end

    sig { params(other: Hand).returns(Integer) }
    def <=>(other)
      return card_value <=> other.card_value if combination == other.combination

      combination <=> other.combination
    end
  end

  class Hand2 < Hand
    sig { params(card: String).returns(Integer) }
    def self.card_value(card)
      return 1 if card == 'J'

      super
    end

    sig { returns(Integer) }
    def combination
      count = @cards.tally
      jokers = count.delete('J') || 0

      counts = count.values.sort
      counts << 0 if counts.empty?
      counts[-1] = (counts[-1] || 0) + jokers

      case counts
      when [5] then 7
      when [1, 4] then 6
      when [2, 3] then 5
      when [1, 1, 3] then 4
      when [1, 2, 2] then 3
      when [1, 1, 1, 2] then 2
      else 1
      end
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @hands = T.let(@input.lines(chomp: true).map { Hand.new(_1) }, T::Array[Hand])
  end

  sig { returns(Integer) }
  def part1
    @hands.sort!
    @hands.each_with_index.sum do |hand, i|
      hand.bid * (i + 1)
    end
  end

  sig { returns(Integer) }
  def part2
    hands = @input.lines(chomp: true).map { Hand2.new(_1) }
    hands.sort!
    hands.each_with_index.sum do |hand, i|
      hand.bid * (i + 1)
    end
  end
end
