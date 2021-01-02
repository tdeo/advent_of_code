# frozen_string_literal: true

require_relative 'intcode'

TILES = {
  0 => ' ',
  1 => '#',
  2 => 'B',
  3 => '-',
  4 => 'o',
}.freeze

class CarePackage
  def initialize(input)
    @input = input
    @intcode = Intcode.new(@input)
  end

  def part1
    c = 0
    @intcode.run_until_input
    loop do
      x, _y, tile = Array.new(3) { @intcode.getint }
      break if x.nil?

      c += 1 if tile == 2
    end
    c
  end

  def print_map
    mini, maxi = @map.keys.map(&:last).minmax
    minj, maxj = @map.keys.map(&:first).minmax

    (mini..maxi).each do |i|
      (minj..maxj).each do |j|
        print @map[[j, i]]
      end
      puts ''
    end
  end

  def move
    # Ball going up, just go towards it
    return @ball[0] <=> @paddle[0] if @ball[1] <= @prev_ball[1]

    # Predict ball landing
    dir = @ball[0] - @prev_ball[0]
    future_ball = @ball.dup
    while future_ball[1] > @paddle[1] + 1
      dir = -dir if @map[[future_ball[0] + dir, future_ball[1] + 1]] == '#'
      future_ball[0] += dir
      future_ball[1] += 1
    end
    future_ball[0] <=> @paddle[0]
  end

  def part2
    @intcode.set(0, 2)
    @map = Hash.new(' ')
    @paddle = nil

    @has_block = nil
    @prev_ball = @ball = nil

    score = 0
    loop do
      @intcode.run_until_input
      loop do
        x, y, tile = Array.new(3) { @intcode.getint }
        break if x.nil?

        if x == -1 && y == 0
          score = tile
        else
          if tile == 4
            @prev_ball = @ball
            @ball = [x, y]
            @prev_ball ||= @ball
          end
          @paddle = [x, y] if tile == 3
          @map[[x, y]] = TILES[tile]
        end
      end
      # print_map # if Random.rand() < 0.1
      return score if @map.count { |_, v| v == 'B' } == 0 # No more blocks

      @intcode.sendint(move)
    end
  end
end
