#! /usr/bin/env ruby

require 'pathname'
require 'active_support/core_ext/string'

dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir dir

args = ARGV

if args.delete('auto')
  t = Time.now.utc - 5 * 60 * 60
  args = [t.year, t.day].map(&:to_s)
end

if (args.delete('-h') || args.delete('--help')) \
  || (args[0] !~ /^\d*$/ || args[1] !~ /^\d*$/)
  puts 'Usage: ./generate.rb <year> <problem number> [name]'
  exit 1
end

year = args[0]
day = args[1].to_s.rjust(2, '0')

filename = args[2] || begin
  page = `curl -sS --cookie "session=#{$session}" -XGET https://adventofcode.com/#{year}/day/#{day.to_i}`
  filename = page[/<h2[^>]*>.*Day\s*\d+:(.*)\s-*<\/h2>/, 1]
end

fail 'Cannot find problem name' if filename.nil?

filename = filename.strip.tr(' ', '').underscore

lib_file = "./#{year}/lib/#{day}_#{filename}.rb"
File.open(lib_file, 'w') do |f|
  f.write <<~LIB
    class #{filename.camelcase}
      def initialize(input)
        @input = input
      end

      def part1
      end

      def part2
      end
    end
  LIB
end unless File.exist?(lib_file)

test_file = "./#{year}/test/#{day}.rb"
File.open(test_file, 'w') do |f|
  f.write <<~TEST
    require 'minitest/autorun'
    require_relative('../lib/#{day}_#{filename}.rb')

    describe #{filename.camelcase} do
      before { @k = #{filename.camelcase} }

      def test_part1
        assert_equal nil, @k.new('input').part1
      end

      def test_part2
        assert_equal nil, @k.new('input').part2
      end
    end
  TEST
end unless File.exist?(test_file)
