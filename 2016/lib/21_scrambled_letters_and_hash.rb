# frozen_string_literal: true

class ScrambledLettersAndHash
  def initialize(input)
    @instructions = input.split("\n")
    @passwd = +'abcdefgh'
  end

  def apply!(ins, reverse: false)
    case ins
    when /^swap position (.*) with position (.*)$/
      @passwd[$1.to_i], @passwd[$2.to_i] = @passwd[$2.to_i], @passwd[$1.to_i]
    when /^swap letter (.*) with letter (.*)$/
      @passwd.tr!("#{$1}#{$2}", "#{$2}#{$1}")
    when /^rotate (left|right) (.*)$/
      @passwd = @passwd.chars
      $2.to_i.times do
        if ($1 == 'right') ^ reverse
          @passwd.unshift(@passwd.pop)
        else
          @passwd.push(@passwd.shift)
        end
      end
      @passwd = @passwd.join
    when /^rotate based on position of letter (.*)$/
      @passwd = @passwd.chars
      idx = @passwd.index($1)
      if reverse
        rotations = 0
        while (idx + 1 + (idx >= (@passwd.size / 2) ? 1 : 0)) != rotations
          @passwd.push(@passwd.shift)
          idx = @passwd.index($1)
          rotations += 1
        end
      else
        (idx + 1 + (idx >= (@passwd.size / 2) ? 1 : 0)).times do
          @passwd.unshift(@passwd.pop)
        end
      end
      @passwd = @passwd.join
    when /^reverse positions (.*) through (.*)$/
      i = $1.to_i
      j = $2.to_i
      @passwd = @passwd[0...i] + @passwd[i..j].reverse + @passwd[(j + 1)..]
    when /^move position (.*) to position (.*)$/
      i = $1.to_i
      j = $2.to_i
      i, j = j, i if reverse
      letter = @passwd[i]
      @passwd = @passwd[0...i] + @passwd[(i + 1)..]
      @passwd = @passwd[0...j] + letter + @passwd[j..]
    else
      raise "unrecognized instruction: #{ins}"
    end
  end

  def part1(passwd = 'abcdefgh')
    @passwd = passwd.dup
    @instructions.each { |ins| apply!(ins) }
    @passwd
  end

  def part2(passwd = 'fbgdceah')
    @passwd = passwd.dup
    @instructions.reverse_each { |ins| apply!(ins, reverse: true) }
    @passwd
  end
end
