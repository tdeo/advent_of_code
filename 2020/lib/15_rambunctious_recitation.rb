# frozen_string_literal: true

class RambunctiousRecitation
  N = 2020

  def initialize(input)
    @input = input
    @orig = input.split(',').map(&:to_i)
    @spoken = Hash.new { |hash, key| hash[key] = [nil, nil] }
    @round = 0
    @last = nil
  end

  def perform!
    @last = if @round < @orig.size
              @orig[@round]
            elsif @spoken.key?(@last) && @spoken[@last][-2]
              @spoken[@last][-1] - @spoken[@last][-2]
            else
              0
            end

    @spoken[@last][-2] = @spoken[@last][-1]
    @spoken[@last][-1] = @round
    @round += 1
  end

  def part1
    N.times { perform! }
    @last
  end

  def part2
    30_000_000.times do
      perform!
    end
    @last
  end
end
