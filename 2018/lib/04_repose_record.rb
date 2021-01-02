# frozen_string_literal: true

class ReposeRecord
  def initialize(input)
    @input = input.split("\n")
    @input.sort!
  end

  def total(times)
    times.each_slice(2).sum { |a, b| (b || 60) - a }
  end

  def parse
    days = {}
    g = 0
    @input.each do |l|
      minute = l.match(/:(\d\d)\]/)[1].to_i
      date = l.match(/\[([\d-]+)\s/)[1]
      if l.include?('begins shift')
        g = l.match(/Guard #(\d+) begins shift/)[1].to_i
      else
        days[date] ||= { guard: g, times: [] }
        days[date][:times] << minute
      end
    end
    days
  end

  def part1
    days = parse

    best_sleep = 0
    best_guard = nil
    sleep_time = Hash.new { |h, k| h[k] = 0 }

    days.each_value do |day|
      sleep_time[day[:guard]] += total(day[:times])
      if sleep_time[day[:guard]] > best_sleep
        best_sleep = sleep_time[day[:guard]]
        best_guard = day[:guard]
      end
    end

    minutes = Hash.new { |h, k| h[k] = 0 }
    best_count = 0
    best_minute = nil
    days.each_value do |day|
      next unless day[:guard] == best_guard

      day[:times].each_slice(2) do |a, b|
        (a...b || 60).each do |m|
          minutes[m] += 1
          if minutes[m] > best_count
            best_count = minutes[m]
            best_minute = m
          end
        end
      end
    end
    best_minute * best_guard
  end

  def part2
    days = parse

    minutes = Hash.new { |h, k| h[k] = 0 }
    best_count = 0
    best = nil
    days.each_value do |day|
      g = day[:guard]
      day[:times].each_slice(2) do |a, b|
        (a...b || 60).each do |m|
          minutes[[m, g]] += 1
          if minutes[[m, g]] > best_count
            best_count = minutes[[m, g]]
            best = [m, g]
          end
        end
      end
    end
    best.reduce(:*)
  end
end
