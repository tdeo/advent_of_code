# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class WarehouseWoes
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    map, moves = @input.split("\n\n")
    @map = T.let(T.must(map).lines(chomp: true), T::Array[String])
    @start = T.let([0, 0], [Integer, Integer])
    @map.each_with_index do |row, i|
      row.each_char.with_index do |char, j|
        @start = [i, j] if char == '@'
      end
    end
    @moves = T.let(T.must(moves), String)
  end

  sig { params(i: Integer, j: Integer).returns(T.nilable(String)) }
  def at(i, j)
    return nil if i < 0 || j < 0 || i >= @map.size || j >= T.must(@map[i]).size

    T.must(@map[i])[j]
  end

  sig { params(i: Integer, j: Integer, val: String).void }
  def set(i, j, val)
    return nil if i < 0 || j < 0 || i >= @map.size || j >= T.must(@map[i]).size

    T.must(@map[i])[j] = val
  end

  sig { params(dir: String).void }
  def move!(dir)
    i, j = @start
    vec = T.let(case dir
                when '^' then [-1, 0]
                when 'v' then [1, 0]
                when '>' then [0, 1]
                when '<' then [0, -1]
                else return
                end, [Integer, Integer],)
    succ = [i + vec[0], j + vec[1]]
    next_non_rock = succ
    next_non_rock = [next_non_rock[0] + vec[0], next_non_rock[1] + vec[1]] while at(*next_non_rock) == 'O'
    return unless at(*next_non_rock) == '.'

    set(*next_non_rock, T.must(at(*succ)))
    set(*succ, '@')
    set(*@start, '.')
    @start = succ
  end

  sig { params(i: Integer, j: Integer, perform: T::Boolean).returns(T.nilable(T::Array[[Integer, Integer]])) }
  def move_up(i = @start[0], j = @start[1], perform: false)
    res = T.let([[i, j]], T::Array[[Integer, Integer]])
    case at(i - 1, j)
    when '#'
      return nil
    when '['
      l = move_up(i - 1, j)
      r = move_up(i - 1, j + 1)
      return nil if l.nil? || r.nil?

      res.concat(l, r)
    when ']'
      l = move_up(i - 1, j - 1)
      r = move_up(i - 1, j)
      return nil if l.nil? || r.nil?

      res.concat(l, r)
    end

    if perform
      res.uniq.sort.each do |ii, jj|
        set(ii - 1, jj, T.must(at(ii, jj)))
        set(ii, jj, '.')
      end
      @start = [i - 1, j]
    end
    res
  end

  sig { params(i: Integer, j: Integer, perform: T::Boolean).returns(T.nilable(T::Array[[Integer, Integer]])) }
  def move_down(i = @start[0], j = @start[1], perform: false)
    res = T.let([[i, j]], T::Array[[Integer, Integer]])
    case at(i + 1, j)
    when '#'
      return nil
    when '['
      l = move_down(i + 1, j)
      r = move_down(i + 1, j + 1)
      return nil if l.nil? || r.nil?

      res.concat(l, r)
    when ']'
      l = move_down(i + 1, j - 1)
      r = move_down(i + 1, j)
      return nil if l.nil? || r.nil?

      res.concat(l, r)
    end

    if perform
      res.uniq.sort.reverse_each do |ii, jj|
        set(ii + 1, jj, T.must(at(ii, jj)))
        set(ii, jj, '.')
      end
      @start = [i + 1, j]
    end
    res
  end

  sig { params(i: Integer, j: Integer, perform: T::Boolean).returns(T.nilable(T::Array[[Integer, Integer]])) }
  def move_left(i = @start[0], j = @start[1], perform: false)
    res = T.let([[i, j]], T::Array[[Integer, Integer]])
    case at(i, j - 1)
    when '#'
      return nil
    when '[', ']'
      l = move_left(i, j - 1)
      return nil if l.nil?

      res.concat(l)
    end

    if perform
      res.uniq.sort.each do |ii, jj|
        set(ii, jj - 1, T.must(at(ii, jj)))
        set(ii, jj, '.')
      end
      @start = [i, j - 1]
    end
    res
  end

  sig { params(i: Integer, j: Integer, perform: T::Boolean).returns(T.nilable(T::Array[[Integer, Integer]])) }
  def move_right(i = @start[0], j = @start[1], perform: false)
    res = T.let([[i, j]], T::Array[[Integer, Integer]])
    case at(i, j + 1)
    when '#'
      return nil
    when '[', ']'
      l = move_right(i, j + 1)
      return nil if l.nil?

      res.concat(l)
    end

    if perform
      res.uniq.sort.reverse_each do |ii, jj|
        set(ii, jj + 1, T.must(at(ii, jj)))
        set(ii, jj, '.')
      end
      @start = [i, j + 1]
    end
    res
  end

  sig { returns(Integer) }
  def gps_sum
    rocks = %w(0 [).to_set
    @map.each_with_index.sum do |row, i|
      row.each_char.with_index.sum do |char, j|
        next 0 unless rocks.include?(char)

        (100 * i) + j
      end
    end
  end

  sig { returns(Integer) }
  def part1
    @moves.each_char { move!(_1) }
    gps_sum
  end

  sig { void }
  def transform_map!
    @map.each do |line|
      line.gsub!('.', '..')
      line.gsub!('#', '##')
      line.gsub!('O', '[]')
      line.gsub!('@', '@.')
    end
    @map.each_with_index do |row, i|
      row.each_char.with_index do |char, j|
        @start = [i, j] if char == '@'
      end
    end
  end

  sig { void }
  def debug!
    puts @map.join("\n")
    puts "\n\n\n"
  end

  sig { returns(Integer) }
  def part2
    transform_map!
    @moves.each_char do |c|
      case c
      when '^' then move_up(perform: true)
      when 'v' then move_down(perform: true)
      when '<' then move_left(perform: true)
      when '>' then move_right(perform: true)
      end
    end
    gps_sum
  end
end
