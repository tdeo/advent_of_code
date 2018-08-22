class RpgSimulator
  def initialize(input)
    @boss = {
      hp: input.scan(/Hit Points: (\d+)\n/)[0][0].to_i,
      damage: input.scan(/Damage: (\d+)\n/)[0][0].to_i,
      armor: input.scan(/Armor: (\d+)\n/)[0][0].to_i,
    }
    @me = { hp: 100, damage: 0, armor: 0 }
  end

  def wins?(adds)
    me = @me.dup
    adds.each do |add|
      me[:damage] += add[:damage].to_i
      me[:armor] += add[:armor].to_i
    end
    boss = @boss.dup
    while me[:hp] > 0 && boss[:hp] > 0
      boss[:hp] -= [1, me[:damage] - boss[:armor]].max
      me[:hp] -= [1, boss[:damage] - me[:armor]].max
    end
    boss[:hp] <= 0
  end

  WEAPONS = [
    { cost: 8, damage: 4 },
    { cost: 10, damage: 5 },
    { cost: 25, damage: 6 },
    { cost: 40, damage: 7 },
    { cost: 74, damage: 8 },
  ]

  ARMORS = [
    {}, # No armor
    { cost: 13, armor: 1 },
    { cost: 31, armor: 2 },
    { cost: 53, armor: 3 },
    { cost: 75, armor: 4 },
    { cost: 102, armor: 5 },
  ]

  RINGS = [
    {},
    {},
    { cost: 25, damage: 1 },
    { cost: 50, damage: 2 },
    { cost: 100, damage: 3 },
    { cost: 20, armor: 1 },
    { cost: 40, armor: 2 },
    { cost: 80, armor: 3 },
  ]

  def part1
    cheapest = 1 << 20
    WEAPONS.each do |weapon|
      ARMORS.each do |armor|
        RINGS.combination(2).each do |ring1, ring2|
          cost = [ring1, ring2, weapon, armor].sum { |a| a[:cost].to_i }
          cheapest = cost if cost < cheapest && wins?([ring1, ring2, armor, weapon])
        end
      end
    end
    cheapest
  end

  def part2
    highest = 0
    WEAPONS.each do |weapon|
      ARMORS.each do |armor|
        RINGS.combination(2).each do |ring1, ring2|
          cost = [ring1, ring2, weapon, armor].sum { |a| a[:cost].to_i }
          highest = cost if cost > highest && !wins?([ring1, ring2, armor, weapon])
        end
      end
    end
    highest
  end
end
