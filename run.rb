#! /usr/bin/env ruby

require 'benchmark'
require 'pathname'

dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir dir

$session = File.read('./session_cookie').strip

$post_to_aoc = ARGV.delete('--post')
$skip_tests = ARGV.delete('--no-test')

unless ARGV.size > 1 && ARGV[0] =~ /\d+/ && ARGV[1] =~ /\d+/
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

def run(year, day, parts)
  day = day.to_s.rjust(2, '0')

  unless $skip_tests
    test_cmd = "ruby #{year}/test/#{day}.rb"
    test_cmd += " -n /test_part#{parts}/" if parts
    test_output = `#{test_cmd}`

    puts "\n******* Tests #{year}-#{day} *******\n\n"
    puts test_output

    if !test_output.include?(' 0 failures') || test_output.include?('\n0 runs')
      exit 1
    end
  end

  parts = [parts || [1, 2]].flatten.map(&:to_i)

  input = `curl -sS --cookie "session=#{$session}" -XGET https://adventofcode.com/#{year}/day/#{day.to_i}/input`

  puts "\n******* Input #{year}-#{day} *******\n\n"
  puts input.split("\n").first(6).join("\n")[0..500]
  puts "...\n"

  file = Dir[Pathname.new(year).join('lib', "#{day}_*.rb")].first
  require_relative file
  klass = Module.const_get(file.gsub(%r{^#{year}/lib/\d+_(.*)\.rb$}, '\1').split('_').map(&:capitalize).join)

  parts.each do |part|
    m = :"part#{part}"
    next unless klass.instance_methods.include?(m)
    puts "\n******* Running part #{part} *******\n\n"
    res = nil
    real = Benchmark.realtime { res = klass.new(input.dup).__send__(m) }
    puts res
    if $post_to_aoc
      resp = `curl -sSL --cookie \"session=#{$session}\" -XPOST https://adventofcode.com/#{year}/day/#{day.to_i}/answer -d \"level=#{part}&answer=#{res}\"`
      puts resp[%r{<main>(.*)</main>}m]
    end
    puts "\n\tRun in #{real.round(2)} seconds"
  end
end

puts ''

run(ARGV[0], ARGV[1], ARGV[2])
