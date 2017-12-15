#! /usr/bin/env ruby

require 'pathname'

dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir dir

session = File.read('./session_cookie').strip

unless ARGV.size > 1 && ARGV[0] =~ /\d+/ && ARGV[1] =~ /\d+/
  puts 'Usage: ./run.rb <year> <problem number>

    The script assumes the following:
      - You have your session cookie in a `session_cookie` file in the same directory.

      - Files are located the following way: ./<year>/lib/<num>_<name>.rb, where is
        0-padded to have 2 digits.

      - The file in question define a class name in the camelcased <name>, which
        can be instantiated and implements the 2 instance methods `part1` and `part2`
        which returns the result of part1 and part2 of the problem.
    '
  exit 1
end

year = ARGV[0]
day = ARGV[1].to_s.rjust(2, '0')

input = `curl -sS --cookie "session=#{session}" -XGET http://adventofcode.com/#{year}/day/#{day.to_i}/input`.strip

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
  puts klass.new(input.dup).__send__(m)
end

puts ''
