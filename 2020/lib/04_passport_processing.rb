class PassportProcessing
  FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid]
  def initialize(input)
    @input = input
    @passports = []

    @input.split("\n\n").each do |passport|
      @passports << passport.split.map { |e| e.split(':') }.to_h
    end
  end

  def part1
    @passports.count { |pass| FIELDS - pass.keys - ['cid'] == [] }
  end

  def valid?(passport)
    return false unless FIELDS - passport.keys - ['cid'] == []

    return false unless (1920..2020).include? passport['byr'].to_i
    return false unless (2010..2020).include? passport['iyr'].to_i
    return false unless (2020..2030).include? passport['eyr'].to_i

    unit = passport['hgt'][-2..-1]
    val = passport['hgt'].to_i
    if unit == 'cm'
      return false unless (150..193).include? val
    elsif unit == 'in'
      return false unless (59..76).include? val
    else
      return false
    end

    return false unless passport['hcl'] =~ /^#[0-9a-f]{6}$/
    return false unless %w[amb blu brn gry grn hzl oth].include? passport['ecl']

    return false unless passport['pid'] =~ /^[0-9]{9}$/

    true
  end

  def part2
    @passports.count { valid?(_1) }
  end
end
