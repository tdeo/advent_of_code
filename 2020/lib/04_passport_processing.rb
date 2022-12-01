# frozen_string_literal: true

class PassportProcessing
  FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid].freeze
  def initialize(input)
    @input = input
    @passports = []

    @input.split("\n\n").each do |passport|
      @passports << passport.split.to_h { |e| e.split(':') }
    end
  end

  def part1
    @passports.count { |pass| FIELDS - pass.keys - %w[cid] == [] }
  end

  def valid?(passport)
    return false unless FIELDS - passport.keys - %w[cid] == []

    return false unless (1920..2020).cover? passport['byr'].to_i
    return false unless (2010..2020).cover? passport['iyr'].to_i
    return false unless (2020..2030).cover? passport['eyr'].to_i

    unit = passport['hgt'][-2..]
    val = passport['hgt'].to_i
    case unit
    when 'cm'
      return false unless (150..193).cover? val
    when 'in'
      return false unless (59..76).cover? val
    else
      return false
    end

    return false unless /^#[0-9a-f]{6}$/.match?(passport['hcl'])
    return false unless %w[amb blu brn gry grn hzl oth].include? passport['ecl']

    return false unless /^[0-9]{9}$/.match?(passport['pid'])

    true
  end

  def part2
    @passports.count { valid?(_1) }
  end
end
