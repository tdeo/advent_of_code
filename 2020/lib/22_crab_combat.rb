# frozen_string_literal: true

class CrabCombat
  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @winner = nil
    end

    def round!
      return @winner = @player2 if @player1.empty?
      return @winner = @player1 if @player2.empty?

      c1, c2 = [@player1, @player2].map(&:shift)

      if c1 > c2
        @player1 << c1 << c2
      elsif c1 < c2
        @player2 << c2 << c1
      else
        raise "It's a tie"
      end
    end

    def play!
      round! while @winner.nil?
    end

    def score
      play! if @winner.nil?
      @winner.reverse_each.each_with_index.sum { |val, i| val * (i + 1) }
    end

    def winner
      play! if @winner.nil?
      @winner == @player1 ? 1 : 2
    end
  end

  class Game2 < Game
    def self.winner(player1, player2)
      @games ||= {}
      @games[[player1, player2]] ||= Game2.new(player1.dup, player2.dup)
      @games[[player1, player2]].winner
    end

    def initialize(*args)
      super
      @viewed = {}
    end

    def round!
      return @winner = @player1 if @viewed[[@player1, @player2]]
      return @winner = @player2 if @player1.empty?
      return @winner = @player1 if @player2.empty?

      @viewed[[@player1.dup, @player2.dup]] = true

      c1, c2 = [@player1, @player2].map(&:shift)

      if @player1.size >= c1 && @player2.size >= c2
        round_winner = Game2.winner(@player1[0...c1], @player2[0...c2])
        if round_winner == 1
          @player1 << c1 << c2
        else
          @player2 << c2 << c1
        end
      elsif c1 > c2
        @player1 << c1 << c2
      else
        @player2 << c2 << c1
      end
    end
  end

  def initialize(input)
    @input = input

    @player1 = []
    @player2 = []

    @input.split("\n\n").each do |player|
      lines = player.split("\n")
      if lines[0].include?('1')
        @player1 = lines[1..].map(&:to_i)
      else
        @player2 = lines[1..].map(&:to_i)
      end
    end
  end

  def part1
    Game.new(@player1.dup, @player2.dup).score
  end

  def part2
    Game2.new(@player1.dup, @player2.dup).score
  end
end
