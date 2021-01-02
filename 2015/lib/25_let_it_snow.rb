# frozen_string_literal: true

class LetItSnow
  MOD = 33_554_393
  MULT = 252_533
  CODE = 20_151_125

  def initialize(input)
    @row = input.scan(/row (\d*)\b/)[0][0].to_i
    @col = input.scan(/column (\d*)\b/)[0][0].to_i
  end

  def index_of(row, col)
    diag_number = row + col - 1
    idx = diag_number * (diag_number - 1) / 2 # indexes filled by previous diagonals
    idx + col
  end

  def next_value(val)
    (val * MULT) % MOD
  end

  def part1
    idx = index_of(@row, @col)
    code = CODE
    i = 1
    viewed = {}
    while i < idx
      viewed[code] = i
      i += 1
      code = next_value(code)
    end
    code
  end

  def part2
    0
  end
end
