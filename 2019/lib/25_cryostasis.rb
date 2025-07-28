# frozen_string_literal: true

require_relative 'intcode'

class Cryostasis
  DIRS = %w[north east south west].freeze

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
      if DIRS.include?(l[0])
        @map[room][l[0]] ||= nil
      else
        items << l[0]
      end
    end
    items
  end

  def take(item)
    return nil if ['infinite loop', 'photons', 'molten lava', 'giant electromagnet', 'escape pod'].include?(item)

    @inventory << item unless @inventory.include?(item)
    "take #{item}"
  end

  def dest
    viewed = { @current_room => [] }
    q = [@current_room]
    until q.empty?
      room = q.shift
      path = viewed[room]

      @map[room].each do |dir, n_room|
        return path + [dir] if n_room.nil?
        next if viewed[n_room]

        viewed[n_room] = path + [dir]
        q << n_room
      end
    end
    nil
  end

  def process_security_checkpoint(output)
    parse(output)
    @map['Security Checkpoint'] = { 'north' => 'Engineering' }
    d = dest
    puts d.inspect
    return "#{d[0]}\n" if d

    items = @inventory.dup
    puts items.inspect
    r = []
    combs = (0...items.size).flat_map { |i| items.combination(i).to_a }
    combs.each do |comb|
      (@inventory - comb).each { |i| r << "drop #{i}" }
      (comb - @inventory).each { |i| r << "take #{i}" }
      @inventory = comb
      r << 'east'
    end
    r.map { |l| "#{l}\n" }.join
  end

  def process(output)
    return process_security_checkpoint(output) if output.include?('== Security Checkpoint ==')

    res = []
    items = parse(output)
    items.each { |item| res << take(item) unless take(item).nil? }
    path = dest
    if path.nil? && !@map['Security Checkpoint'].key?('east')
      @map['Security Checkpoint']['east'] = nil
      path = dest
    end

    res << path[0]
    @prev_dir = path[0]
    res.map { |l| "#{l}\n" }.join
  end

  def part1
    loop do
      @intcode.run_until_input
      output = ''
      output += @intcode.getint.chr while @intcode.output?
      break if @intcode.finished?

      line = process(output)
      break if line.nil?

      line.each_char { |c| @intcode.sendint(c.ord) }
    end
  end

  def part2
    0
  end
end
