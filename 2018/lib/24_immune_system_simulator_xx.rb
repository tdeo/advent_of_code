class ImmuneSystemSimulatorXx
  class Group
    attr_accessor :n, :hp, :attack, :type, :initiative, :weaknesses, :immunities, :idx, :cat

    def initialize(str, idx, cat)
      m = str.match(/^(\d+) units each with (\d+) hit points (\([^)]+\) )?with an attack that does (\d+) ([^\s]+) damage at initiative (\d+)$/)
      fail "Unrecognized group: #{str}" if m.nil?

      @cat = cat
      @idx = idx + 1
      @n = m[1].to_i
      @hp = m[2].to_i


      extra = m[3]
      @immunities = []
      @weaknesses = []
      if extra
        @immunities = extra[/immune to ([^);]+)/, 1]&.split(', ') || []
        @weaknesses = extra[/weak to ([^);]+)/, 1]&.split(', ') || []
      end

      @attack = m[4].to_i
      @type = m[5]
      @initiative = m[6].to_i
    end

    def effective_power
      @attack * @n
    end

    def damage_to(other)
      return 0 if other.immunities.include?(@type)

      dmg = effective_power
      dmg *= 2 if other.weaknesses.include?(@type)
      dmg
    end

    def take_dmg(dmg)
      units_lost = [dmg / hp, @n].min
      @n -= units_lost
      units_lost
    end
  end

  def initialize(input)
    @input = input
    parse(input)
  end

  def parse(input)
    @immune = []
    @infection =[]

    cur = nil

    input.split("\n").each do |l|
      if l.empty?
        next
      elsif l == 'Immune System:'
        cur = :@immune
      elsif l == 'Infection:'
        cur = :@infection
      elsif l =~ /^\d+ units each with/
        instance_variable_get(cur) << Group.new(
          l, instance_variable_get(cur).size, cur
        )
      end
    end
  end

  def targets
    targets = {}
    groups = @immune + @infection
    groups.sort_by! { |e| [-e.effective_power, -e.initiative] }

    taken = {}

    groups.each do |g|
      ennemies = (g.cat == :@immune) ? @infection : @immune
      ennemies = ennemies.reject { |e| taken[e] }
      target = ennemies.max_by { |e| [g.damage_to(e), e.effective_power, e.initiative] }

      next unless target && g.damage_to(target) > 0

      targets[g] = target
      taken[targets[g]] = true
    end

    targets
  end

  def attack(targets)
    groups = @immune + @infection
    groups.sort_by! { |g| -g.initiative }

    groups.each do |g|
      next if g.n <= 0
      t = targets[g]
      next if t.nil?
      t.take_dmg(g.damage_to(t))
    end
  end

  def print!
    puts "Immune System:"
    @immune.each { |g| puts "Group #{g.idx} contains #{g.n} units" }
    puts "Infection:"
    @infection.each { |g| puts "Group #{g.idx} contains #{g.n} units" }
    puts ""
  end

  def round!
    attack(targets)
    @immune.delete_if { |g| g.n <= 0 }
    @infection.delete_if { |g| g.n <= 0 }
  end

  def alive
    [@immune, @infection].map { |groups| groups.map(&:n).sum }.sum
  end

  def part1
    prev = nil
    while @immune.size > 0 && @infection.size > 0
      round!
      return nil if alive == prev # We're in a loop
      prev = alive
    end
    alive
  end

  def part2
    boost = 0
    while true
      parse(@input)
      @immune.each { |g| g.attack = g.attack + boost }
      res = part1
      boost += 1
      return res if @infection.size == 0
    end
  end
end
