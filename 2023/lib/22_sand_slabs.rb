# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class SandSlabs
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @pieces = T.let(input.lines(chomp: true).map do |line|
      a, b = line.split('~')

      xa, ya, za = T.must(a).split(',')
      xb, yb, zb = T.must(b).split(',')

      [
        [xa.to_i, ya.to_i, za.to_i],
        [xb.to_i, yb.to_i, zb.to_i],
      ]
    end, T::Array[[[Integer, Integer, Integer], [Integer, Integer, Integer]]],)

    @pieces.each(&:sort!)
    @pieces.sort_by! { _1.first.last }
  end

  sig { returns(T::Hash[Integer, T::Set[Integer]]) }
  def relies_on
    result = T.let({}, T::Hash[Integer, T::Set[Integer]])

    top_pieces = T.let({}, T::Hash[[Integer, Integer], [Integer, Integer]])
    @pieces.each_with_index do |((x1, y1, z1), (x2, y2, z2)), index|
      index += 1

      max_height = 0
      supported_by = T.let(Set.new, T::Set[Integer])

      (x1..x2).each do |x|
        (y1..y2).each do |y|
          h, piece = top_pieces[[x, y]]
          next unless h && piece

          if h > max_height
            max_height = h
            supported_by.clear << piece
          elsif h == max_height
            supported_by << piece
          end
        end
      end
      max_height += (z2 - z1 + 1)

      (x1..x2).each do |x|
        (y1..y2).each do |y|
          top_pieces[[x, y]] = [max_height, index]
        end
      end

      result[index] = supported_by
    end

    result
  end

  sig { returns(Integer) }
  def part1
    destroyable = T.let((1..@pieces.size).to_set, T::Set[Integer])
    relies_on.each_value do |supported_by|
      destroyable.delete(T.must(supported_by.first)) if supported_by.size == 1
    end
    destroyable.size
  end

  sig { params(piece: Integer, relied_upon: T::Hash[Integer, T::Set[Integer]], relies_on: T::Hash[Integer, T::Set[Integer]]).returns(Integer) }
  def chain_reaction(piece, relied_upon, relies_on)
    destroyed = T.let(Set.new, T::Set[Integer])
    destroyed << piece

    q = [piece]
    while q.any?
      head = T.must(q.shift)
      relied_upon[head]&.each do |above|
        if T.must(relies_on[above]).all? { destroyed.include?(_1) }
          destroyed << above
          q << above
        end
      end
    end

    destroyed.size - 1
  end

  sig { returns(Integer) }
  def part2
    relies_on = relies_on()
    relied_upon = T.let({}, T::Hash[Integer, T::Set[Integer]])
    relies_on.each do |piece, supported_by|
      supported_by.each do |supported_by_piece|
        relied_upon[supported_by_piece] ||= Set.new
        T.must(relied_upon[supported_by_piece]) << piece
      end
    end

    (1..@pieces.size).map { chain_reaction(_1, relied_upon, relies_on) }.sum
  end
end
