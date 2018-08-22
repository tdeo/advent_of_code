class HaltingProblem
  def initialize(input)
    @steps = input.match(/Perform a diagnostic checksum after (\d+) steps./)[1].to_i
    @tape = Hash.new { |h, k| h[k] = 0 }
    @cursor = 0
    @state = input.match(/Begin in state (.*)\./)[1]

    @state_actions = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = {} } }
    cur_state = cur_value = nil
    input.split("\n").each do |l|
      line = l.strip
      if line.start_with? 'In state '
        cur_state = line.match(/In state (.*):/)[1]
        next
      end
      if line.start_with? 'If the current value is '
        cur_value = line.match(/If the current value is (\d+):/)[1].to_i
        next
      end
      if line.start_with? '- '
        if line.start_with? '- Write the value '
          @state_actions[cur_state][cur_value][:write] = \
            line.match(/- Write the value (\d)\./)[1].to_i
        end
        if line.start_with? '- Move one slot to the '
          dir = line.match(/- Move one slot to the (.*)\./)[1]
          @state_actions[cur_state][cur_value][:move] = if dir == 'left'
                                                          -1
                                                        elsif dir == 'right'
                                                          1
                                                        end
        end
        if line.start_with? '- Continue with state '
          @state_actions[cur_state][cur_value][:continue] = \
            line.match(/- Continue with state (.*)\./)[1]
        end
      end
    end
  end

  def current
    @tape[@cursor]
  end

  def write(val)
    @tape[@cursor] = val
  end

  def move(i)
    @cursor += i
  end

  def continue(val)
    @state = val
  end

  def execute_state!
    @state_actions[@state][current].each do |k, v|
      __send__(k, v)
    end
  end

  def print!
    puts @tape.keys.sort.map { |k| @tape[k] }.join(' ')
    puts "State #{@state}, idx #{@cursor}"
  end

  def ones
    @tape.count { |k, v| v == 1 }
  end

  def part1
    @steps.times do |i|
      execute_state!
      puts i if i % 500_000 == 0
    end
    ones
  end

  def part2
    0
  end
end
