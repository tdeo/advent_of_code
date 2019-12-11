require_relative './05_sunnywitha_chanceof_asteroids'

class AmplificationCircuit < SunnywithaChanceofAsteroids
  def initialize(input)
    @input = input
    super
  end

  def part1
    best = -1
    opts = [0,1,2,3,4]
    opts.permutation do |opt|
      a = self.class.new(@input).sendint(opt[0]).sendint(0).execute
      b = self.class.new(@input).sendint(opt[1]).sendint(a).execute
      c = self.class.new(@input).sendint(opt[2]).sendint(b).execute
      d = self.class.new(@input).sendint(opt[3]).sendint(c).execute
      e = self.class.new(@input).sendint(opt[4]).sendint(d).execute
      if e > best
        best = e
      end
    end
    best
  end

  def sendint(val = nil)
    super(val) unless val.nil?
  end

  def execute
    @i ||= 0

    while true do
      ins = instruction

      break if ins == 99
      break if ins == 3 && @stdin.empty? # We need to wait for more input

      compute
      @i += increment(ins)
      return @stdout.shift if ins == 4 # Let's return the output to send it to other process
    end
    nil
  end

  def part2
    best = -1
    opts = [5,6,7,8,9]
    opts.permutation do |opt|
      last = nil
      a = self.class.new(@input).sendint(opt[0]).sendint(0)
      b = self.class.new(@input).sendint(opt[1])
      c = self.class.new(@input).sendint(opt[2])
      d = self.class.new(@input).sendint(opt[3])
      e = self.class.new(@input).sendint(opt[4])
      while true do
        aa = a.execute
        b.sendint(aa)
        bb = b.execute
        c.sendint(bb)
        cc = c.execute
        d.sendint(cc)
        dd = d.execute
        e.sendint(dd)
        ee = e.execute
        a.sendint(ee)
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
