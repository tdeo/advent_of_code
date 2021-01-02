# frozen_string_literal: true

class SpaceStoichiometry
  def initialize(input)
    @input = input
    @reactions = {}
    @input.each_line do |l|
      left, right = l.split(' => ')
      q, val = right.strip.split(' ')
      @reactions[val] = { q: q.to_i, in: [] }
      left.strip.split(', ').each do |elem|
        q2, val2 = elem.split(' ')
        @reactions[val][:in] << [val2, q2.to_i]
      end
    end
  end

  def part1(target = 1)
    needs = Hash.new { |h, k| h[k] = 0 }
    needs['FUEL'] = target

    loop do
      k, v = needs.find { |kk, vv| kk != 'ORE' && vv > 0 }
      return needs['ORE'] if k.nil?

      reaction = @reactions[k]

      times = (v * 1.0 / reaction[:q]).ceil

      needs[k] -= times * reaction[:q]
      reaction[:in].each do |elem|
        needs[elem[0]] += elem[1] * times
      end
    end
  end

  def part2
    trillion = 10**12
    can = 0
    cannot = trillion + 1

    while cannot > can + 1
      middle = (cannot + can) / 2
      v = part1(middle)
      if v > trillion
        cannot = middle
      else
        can = middle
      end
    end
    can
  end
end
