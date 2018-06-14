class ScrambledLettersAndHash
  def initialize(input)
    @instructions = input.split("\n")
    @passwd = 'abcdefgh'
  end

  def apply!(ins, reverse: false)
    case
    when ins =~ /^swap position (.*) with position (.*)$/
      @passwd[$1.to_i], @passwd[$2.to_i] = @passwd[$2.to_i], @passwd[$1.to_i]
    when ins =~ /^swap letter (.*) with letter (.*)$/
      @passwd.tr!("#{$1}#{$2}", "#{$2}#{$1}")
    when ins =~ /^rotate (left|right) (.*)$/
      @passwd = @passwd.chars
      $2.to_i.times do
        if ($1 == 'right') ^ (reverse)
          @passwd.unshift(@passwd.pop)
        else
          @passwd.push(@passwd.shift)
        end
      end
      @passwd = @passwd.join
    when ins =~ /^rotate based on position of letter (.*)$/
      @passwd = @passwd.chars
      if !reverse
        idx = @passwd.index($1)
        (idx + 1 + (idx >= (@passwd.size / 2) ? 1 : 0)).times do |rotations|
          @passwd.unshift(@passwd.pop)
        end
      else
        idx = @passwd.index($1)
        rotations = 0
        while (idx + 1 + (idx >= (@passwd.size / 2) ? 1 : 0)) != rotations do
          @passwd.push(@passwd.shift)
          idx = @passwd.index($1)
          rotations += 1
        end
      end
      @passwd = @passwd.join
    when ins =~ /^reverse positions (.*) through (.*)$/
      i, j = $1.to_i, $2.to_i
      @passwd = @passwd[0...i] + @passwd[i..j].reverse + @passwd[j+1..-1]
    when ins =~ /^move position (.*) to position (.*)$/
      i, j = $1.to_i, $2.to_i
      i, j = j, i if reverse
      letter = @passwd[i]
      @passwd = @passwd[0...i] + @passwd[i + 1..-1]
      @passwd = @passwd[0...j] + letter + @passwd[j..-1]
    else
      fail "unrecognized instruction: #{ins}"
    end
  end

  def part1(passwd = 'abcdefgh')
    @passwd = passwd
    @instructions.each { |ins| apply!(ins) }
    @passwd
  end

  def part2(passwd = 'fbgdceah')
    @passwd = passwd
    @instructions.reverse.each { |ins| apply!(ins, reverse: true) }
    @passwd
  end
end
