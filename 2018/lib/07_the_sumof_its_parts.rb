class TheSumofItsParts
  def initialize(input)
    @input = input
    @before = Hash.new { |h, k| h[k] = {} }
    @input.each_line do |l|
      @before[l[/before step (\w+) can begin/, 1]][l[/Step (\w+) must be/, 1]] = Float::INFINITY
    end
  end

  def part1
    steps = {}
    @before.each do |k, v|
      steps[k] = false
      v.each { |e, _| steps[e] = false }
    end
    steps = steps.keys.sort
    order = []
    while !steps.empty?
      to_do = nil
      steps.each do |s|
        if @before[s].empty?
          to_do = s
          break
        end
      end
      steps.delete(to_do)
      order << to_do
      @before.each { |_, v| v.delete(to_do) }
    end
    order.join('')
  end

  def can_start_at(step, schedule, workers: 5)
    [
      schedule[-workers]&.last || 0,
      @before[step].values.max || 0,
    ].max
  end

  def part2(time: 60, workers: 5)
    steps = {}
    @before.each do |k, v|
      steps[k] = false
      v.each { |e, _| steps[e] = false }
    end
    steps = steps.keys.sort

    schedule = [] # array of [task, endtime]

    while !steps.empty?
      to_do = nil

      steps.sort_by! { |e| [can_start_at(e, schedule, workers: workers), e] }

      to_do = steps.first
      starts_at = can_start_at(to_do, schedule, workers: workers)
      finishes_at = starts_at + time + 1 + to_do.ord - 'A'.ord

      steps.delete(to_do)
      schedule << [to_do, finishes_at]
      schedule.sort_by!(&:last)
      @before.each { |_, v| v[to_do] = finishes_at if v.key?(to_do) }
    end
    schedule.map(&:last).max
  end
end
