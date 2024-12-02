#! /usr/bin/env ruby
# frozen_string_literal: true

require 'benchmark'
require 'pathname'
require 'fileutils'

dir = __dir__
Dir.chdir dir

def session_cookie
  @session_cookie ||= begin
    File.read('./session_cookie').strip
  rescue StandardError
    puts 'Please add your adventofcode.com session cookie into the `session_cookie` file'
    exit 1
  end
end

@post_to_aoc = ARGV.delete('--post')
@skip_tests = ARGV.delete('--no-test')

unless ARGV.size > 1 && ARGV[0] =~ /\d+/ && (ARGV[1] =~ /\d+/ || ARGV[1] == 'benchmark')
  puts <<~HELP
    Usage: ./run.rb <year> <problem number>

    The script assumes the following:
      - You have your session cookie in a `session_cookie` file in the same directory.

      - Files are located the following way: ./<year>/lib/<num>_<name>.rb, where <num> is
        0-padded to have 2 digits.

      - The file in question defines a class named with camelcased <name>, which
        can be instantiated with a puzzle input and implements the 2 instance
        methods `part1` and `part2` which returns the result of part1 and
        part2 of the problem.
  HELP
  exit 1
end

def init_year(year)
  FileUtils.mkdir_p([
    Pathname.new(File.dirname(__FILE__)).join(year, 'lib'),
    Pathname.new(File.dirname(__FILE__)).join(year, 'test'),
    Pathname.new(File.dirname(__FILE__)).join(year, 'inputs'),
  ])
end

def input(year, day)
  init_year(year)
  day = day.to_s.rjust(2, '0')
  file = "#{year}/inputs/#{day}.input"
  unless File.exist?(file)
    input = `curl -sS --cookie "session=#{session_cookie}" -XGET https://adventofcode.com/#{year}/day/#{day.to_i}/input`
    raise input if input.include?('Puzzle inputs differ by user')

    File.write(file, input)
  end
  File.read(file)
end

def run(year, day, parts)
  init_year(year)
  day = day.to_s.rjust(2, '0')

  test_file = "#{year}/test/#{day}.rb"
  if File.exist?(test_file) && !@skip_tests
    test_cmd = "bundle exec ruby #{test_file}"
    test_cmd += " -n /test_part#{parts}/" if parts
    puts test_cmd
    test_output = `#{test_cmd}`

    puts "\n******* Tests #{year}-#{day} *******\n\n"
    puts test_output

    test_success = true
    test_success = false unless test_output.include?(' 0 failures')
    test_success = false unless test_output.include?(' 0 errors')

    exit 1 unless test_success
  end

  parts = [parts || [1, 2]].flatten.map(&:to_i)

  input = input(year, day)

  puts "\n******* Input #{year}-#{day} *******\n\n"
  puts input.split("\n").first(6).join("\n")[0..500]
  puts "...\n"

  file = Dir[Pathname.new(year).join('lib', "#{day}_*")].first.to_s
  require_relative file
  klass = Module.const_get(file.gsub(%r{^#{year}/lib/\d+_(.*)\.rb$}, '\1').split('_').map(&:capitalize).join) # rubocop:disable Sorbet/ConstantsFromStrings

  parts.map do |part|
    m = :"part#{part}"
    next unless klass.instance_methods.include?(m)

    puts "\n******* Running part #{part} *******\n\n"
    res = nil
    real = Benchmark.realtime { res = klass.new(input.dup).__send__(m) }
    puts res
    if @post_to_aoc
      resp = `curl -sSL --cookie \"session=#{session_cookie}\" -XPOST https://adventofcode.com/#{year}/day/#{day.to_i}/answer -d \"level=#{part}&answer=#{res}\"` # rubocop:disable Layout/LineLength
      puts resp[%r{<main>(.*)</main>}m]
    end
    puts "\n\tRun in #{real.round(2)} seconds"
    real
  end
end

def benchmark(year)
  @skip_tests = true
  '01'.upto('25').each do |day|
    times = run(year, day, [1, 2])
    warn "#{year} - #{day}: #{times[0].round(4).to_s.rjust(10)} #{times[1].round(4).to_s.rjust(10)}"
  end
end

if ARGV[1] == 'benchmark'
  benchmark(ARGV[0])
  exit 0
end

puts ''

run(ARGV[0], ARGV[1], ARGV[2])
