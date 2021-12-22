# frozen_string_literal: true

class DiracDice
  ROLLS = 3
  GRID_SIZE = 10
  WINNING_SCORE = 1000

  def initialize(input)
    @input = input
    lines = input.split("\n")
    @players = lines.map { _1.split('position: ')[1].to_i }
    @scores = @players.map { 0 }
    @dice = deterministic_dice
    @current_player = 0
    @roll_count = 0
  end

  def deterministic_dice
    Enumerator.new do |enum|
      current = 1
      loop do
        enum << current
        current = (current % 100) + 1
      end
    end
  end

  def round!
    roll = ROLLS.times.sum { @dice.next }
    @roll_count += ROLLS
    @players[@current_player] += roll % GRID_SIZE
    @players[@current_player] -= GRID_SIZE while @players[@current_player] > GRID_SIZE
    @scores[@current_player] += @players[@current_player]
    @current_player = (1 + @current_player) % @players.size
  end

  def win?
    @scores.any? { _1 >= WINNING_SCORE }
  end

  def part1
    round! until win?
    @roll_count * @scores.min
  end

  def part2
    winning_score = 21
    rolls = [1, 2, 3]
    initial = [1, *@players, *@scores]
    q = [initial]
    paths = Hash.new(0).merge({ initial => 1 })
    wins = { 1 => 0, 2 => 0 }

    until q.empty?
      cur = q.shift
      combinations = paths[cur]
      paths.delete(cur)
      player, pos1, pos2, score1, score2 = cur
      if score1 >= winning_score
        wins[1] += combinations
        next
      end
      if score2 >= winning_score
        wins[2] += combinations
        next
      end

      rolls.product(rolls, rolls).each do |a, b, c|
        roll = a + b + c

        succ = if player == 1
                 npos = ((pos1 + roll - 1) % GRID_SIZE) + 1
                 [
                   2,
                   npos,
                   pos2,
                   score1 + npos,
                   score2,
                 ]
               else
                 npos = ((pos2 + roll - 1) % GRID_SIZE) + 1
                 [
                   1,
                   pos1,
                   npos,
                   score1,
                   score2 + npos,
                 ]
               end

        q << succ unless paths.key?(succ)
        paths[succ] += combinations
      end
    end

    wins.values.max
  end
end
