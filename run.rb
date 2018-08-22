#! /usr/bin/env ruby

require 'benchmark'
require 'pathname'

dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir dir

session = File.read('./session_cookie').strip

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

post_to_aoc = ARGV.delete('--post')

year = ARGV[0]
day = ARGV[1].to_s.rjust(2, '0')

input = `curl -sS --cookie "session=#{session}" -XGET http://adventofcode.com/#{year}/day/#{day.to_i}/input`

puts "\n*******          Input         *******\n\n"
puts input.split("\n").first(12).join("\n")[0..500]
puts "...\n"

parts = ARGV[2] ? [ARGV[2].to_i] : [1, 2]

file = Dir[Pathname.new(year).join('lib', "#{day}_*")].first
require_relative file
klass = Module.const_get(file.gsub(%r{^#{year}/lib/\d+_(.*)\.rb$}, '\1').split('_').map(&:capitalize).join)

parts.each do |part|
  m = part == 1 ? :part1 : :part2
  next unless klass.instance_methods.include?(m)
  puts "\n******* Running part #{part} *******\n\n"
  res = nil
  real = Benchmark.realtime { res = klass.new(input.dup).__send__(m) }
  puts res
  if post_to_aoc
    resp = `curl -sSL --cookie \"session=#{session}\" -XPOST http://adventofcode.com/#{year}/day/#{day.to_i}/answer -d \"level=#{part}&answer=#{res}\"`
    puts resp[%r{<main>(.*)</main>}m]
  end
  puts "\n\tRun in #{real.round(2)} seconds"
end

puts ''
