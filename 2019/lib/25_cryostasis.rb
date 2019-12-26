require_relative 'intcode'

class Cryostasis
  def initialize(input)
    @input = input
    @intcode = Intcode.new(input)
    @map = Hash.new { |h, k| h[k] = {} }
    @inventory = []
    @current_room = @prev_room = @prev_dir = nil
  end

  def parse(output)
    room = output.match(/^== (.*) ==$/)[1]
    puts [@prev_room, @prev_dir, room].join(' | ')
    @map[@prev_room][@prev_dir] = room
    @prev_room = room
    @current_room = room
    items = []
    output.scan(/^- (.*)$/).each do |l|
      if %w(north east south west).include?(l[0])
        @map[room][l[0]] ||= nil
      else
        items << l[0]
      end
    end
    return items
  end

  def take(item)
    return nil if ['infinite loop', 'photons', 'molten lava', 'giant electromagnet', 'escape pod'].include?(item)
    @inventory << item unless @inventory.include?(item)
    "take #{item}"
  end

  def dest
    viewed = { @current_room => [] }
    q = [@current_room]
    while !q.empty? do
      room = q.shift
      path = viewed[room]

      @map[room].each do |dir, n_room|
        return path + [dir] if n_room.nil?
        next if viewed[n_room]
        viewed[n_room] = path + [dir]
        q << n_room
      end
    end
    return nil
  end

  def process_security_checkpoint(output)
    items = parse(output)
    @map['Security Checkpoint'] = { 'north' => 'Engineering' }
    d = dest
    puts d.inspect
    if d
      return "#{d[0]}\n"
    end
    items = @inventory.dup
    puts items.inspect
    r = []
    combs = (0...items.size).flat_map { |i| items.combination(i).to_a }
    combs.each do |comb|
      (@inventory - comb).each { |i| r << "drop #{i}" }
      (comb - @inventory).each { |i| r << "take #{i}" }
      @inventory = comb
      r << "east"
    end
    r.map { |l| "#{l}\n" }.join
  end

  def process(output)
    if output.include?('== Security Checkpoint ==')
      return process_security_checkpoint(output)
    end
    res = []
    items = parse(output)
    items.each { |item| res << take(item) unless take(item).nil? }
    path = dest()
    if path.nil? && !@map['Security Checkpoint'].key?('east')
      @map['Security Checkpoint']['east'] = nil
      path = dest()
    end

    res << path[0]
    @prev_dir = path[0]
    return res.map { |l| "#{l}\n"}.join
  end


  def part1
    while true do
      @intcode.run_until_input
      output = ''
      while @intcode.has_output? do
        output += @intcode.getint.chr
      end
      puts output
      break if @intcode.finished?
      line = process(output)
      pp @map
      if line.nil?
        break
      end
      line.each_char { |c| @intcode.sendint(c.ord) }
    end
  end

  def part2
    true
  end
end
