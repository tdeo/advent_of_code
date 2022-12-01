# frozen_string_literal: true

class FireHazard
  def initialize(input)
    @lights = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0 } }
    @instructions = input.split("\n")
  end

  def apply!(ins)
    case ins
    when /turn on (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] = 1
        end
      end
    when /toggle (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] = 1 - @lights[i][j]
        end
      end
    when /turn off (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] = 0
        end
      end
    end
  end

  def part1
    @instructions.each { |ins| apply!(ins) }
    @lights.sum { |_, v| v.count { |_, v2| v2 == 1 } }
  end

  def apply2!(ins)
    case ins
    when /turn on (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] += 1
        end
      end
    when /toggle (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] += 2
        end
      end
    when /turn off (\d+),(\d+) through (\d+),(\d+)/
      (($1)..($3)).each do |i|
        (($2)..($4)).each do |j|
          @lights[i][j] -= 1 if @lights[i][j] > 0
        end
      end
    end
  end

  def part2
    @instructions.each { |ins| apply2!(ins) }
    @lights.sum { |_, v| v.values.sum }
  end
end
