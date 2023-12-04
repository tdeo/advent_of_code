# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CubeConundrum
  extend T::Sig

  class Game < T::Struct
    prop :index, Integer, default: 0
    prop :red, Integer, default: 0
    prop :green, Integer, default: 0
    prop :blue, Integer, default: 0
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @games = T.let(
      @input.split("\n").map do |line|
        game, rounds = line.split(': ')
        recap = Game.new(index: T.must(game)[/\d+/].to_i)

        T.must(rounds).split('; ').each do |round|
          round.split(', ').each do |cubes|
            count, color = cubes.split
            case color&.strip
            when 'red'
              recap.red = [recap.red, count.to_i].max
            when 'blue'
              recap.blue = [recap.blue, count.to_i].max
            when 'green'
              recap.green = [recap.green, count.to_i].max
            end
          end
        end
        recap
      end,
      T::Array[Game],
    )
  end

  sig { returns(Integer) }
  def part1
    @games.sum do |game|
      next 0 unless game.red <= 12 && game.green <= 13 && game.blue <= 14

      game.index
    end
  end

  sig { returns(Integer) }
  def part2
    @games.sum do |game|
      game.red * game.green * game.blue
    end
  end
end
