class GridComputing
  def initialize(input)
    @nodes = {}
    input.each_line do |l|
      next unless l =~ %r|^/dev/grid/node-x(\d+)-y(\d+)\s*\d+T\s*(\d+)T\s*(\d+)T\s*\d+%$|
      @nodes[$1.to_i] ||= {}
      @nodes[$1.to_i][$2.to_i] = { used: $3.to_i, avail: $4.to_i }
    end
  end

  def part1
    viable = 0
    @nodes.each_key do |x1|
      @nodes.each_key do |x2|
        @nodes[x1].each_key do |y1|
          @nodes[x2].each_key do |y2|
            next if @nodes[x1][y1][:used] == 0
            next if x1 == x2 && y1 == y2
            next if @nodes[x1][y1][:used] > @nodes[x2][y2][:avail]
            viable += 1
          end
        end
      end
    end
    viable
  end

  def sym(node)
    if node[:used] == 0
      '_'
    elsif node[:used] < 85
      '.'
    elsif node[:avail] < 64
      '#'
    end
  end

  def part2
    # This draws the map (x and y switched),
    # From there, we can count the moves needed:
    # The empty tiles begins on (17, 22), and we need:
    # - 17 moves to get in in (0, 22)
    # - 22 for (0, 0)
    # - 35 for (35, 0) (which gets the target in (34, 0))
    # - 34 * 5 moves patterns to get the target back up to (0, 0)
    # This adds up to 17 + 22 + 35 + 34 * 5 = 244
    puts @nodes.each_value.flat_map { |v| v.each_value.map { |v2| v2[:used] } }.sort.uniq.join(' ')
    puts @nodes.each_value.flat_map { |v| v.each_value.map { |v2| v2[:avail] } }.sort.uniq.join(' ')

    puts "#{@nodes.keys.max} #{@nodes.values.first.keys.max}"

    puts '   ' + @nodes.values.first.keys.sort.map { |k| k.to_s.ljust(3) }.join
    @nodes.keys.sort.each do |key|
      puts key.to_s.ljust(3) + @nodes[key].keys.sort.map { |k| sym(@nodes[key][k]) }.join('  ')
    end
    nil
  end
end
