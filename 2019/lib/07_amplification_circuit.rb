require_relative 'intcode'

class AmplificationCircuit
  def initialize(input)
    @input = input
  end

  def part1
    best = -1
    opts = [0,1,2,3,4]
    opts.permutation do |opt|
      a = Intcode.new(@input).sendint(opt[0]).sendint(0).run.getint
      b = Intcode.new(@input).sendint(opt[1]).sendint(a).run.getint
      c = Intcode.new(@input).sendint(opt[2]).sendint(b).run.getint
      d = Intcode.new(@input).sendint(opt[3]).sendint(c).run.getint
      e = Intcode.new(@input).sendint(opt[4]).sendint(d).run.getint
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
      a = Intcode.new(@input).sendint(opt[0]).sendint(0)
      b = Intcode.new(@input).sendint(opt[1])
      c = Intcode.new(@input).sendint(opt[2])
      d = Intcode.new(@input).sendint(opt[3])
      e = Intcode.new(@input).sendint(opt[4])
      aa = bb = cc = dd = ee = nil
      while true do
        a.run_until_input
        aa = a.getint
        b.sendint(aa) unless aa.nil?
        b.run_until_input
        bb = b.getint
        c.sendint(bb) unless bb.nil?
        c.run_until_input
        cc = c.getint
        d.sendint(cc) unless cc.nil?
        d.run_until_input
        dd = d.getint
        e.sendint(dd) unless dd.nil?
        e.run_until_input
        ee = e.getint
        a.sendint(ee) unless ee.nil?
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
