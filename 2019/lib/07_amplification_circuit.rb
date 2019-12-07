require_relative './05_sunnywitha_chanceof_asteroids'

class AmplificationCircuit
  def initialize(input)
    @input = input
  end

  def part1
    best = -1
    opts = [0,1,2,3,4]
    opts.permutation do |opt|
      a = SunnywithaChanceofAsteroids.new(@input).part1([opt[0], 0])
      b = SunnywithaChanceofAsteroids.new(@input).part1([opt[1], a])
      c = SunnywithaChanceofAsteroids.new(@input).part1([opt[2], b])
      d = SunnywithaChanceofAsteroids.new(@input).part1([opt[3], c])
      e = SunnywithaChanceofAsteroids.new(@input).part1([opt[4], d])
      if e > best
        best = e
      end
    end
    best
  end

  def part2
    best = -1
    opts = [5,6,7,8,9]
    opts.permutation do |opt|
      last = nil
      ain = [opt[0], 0]
      bin = [opt[1]]
      cin = [opt[2]]
      din = [opt[3]]
      ein = [opt[4]]
      a = SunnywithaChanceofAsteroids.new(@input)
      b = SunnywithaChanceofAsteroids.new(@input)
      c = SunnywithaChanceofAsteroids.new(@input)
      d = SunnywithaChanceofAsteroids.new(@input)
      e = SunnywithaChanceofAsteroids.new(@input)
      while true do
        aa = a.part1(ain)
        bin << aa
        bb = b.part1(bin)
        cin << bb
        cc = c.part1(cin)
        din << cc
        dd = d.part1(din)
        ein << dd
        ee = e.part1(ein)
        ain << ee
        last = ee unless ee.nil?
        break if [aa,bb,cc,dd,ee].all?(&:nil?)
      end
      if last > best
        best = last
      end
    end
    best
  end
end
