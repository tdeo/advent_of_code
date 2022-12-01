#! /usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'active_support/core_ext/string'

dir = __dir__
Dir.chdir dir

args = ARGV

if args.delete('auto')
  t = Time.now.utc - (5 * 60 * 60)
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
  page = `curl -sS -XGET https://adventofcode.com/#{year}/day/#{day.to_i}`
  page[%r{<h2[^>]*>.*Day\s*\d+:(.*)\s-*</h2>}, 1]
end

raise 'Cannot find problem name' if filename.nil?

filename = filename.strip.gsub(/[^A-Za-z]/, '').underscore

lib_file = "./#{year}/lib/#{day}_#{filename}.rb"
unless File.exist?(lib_file)
  File.write(lib_file, <<~LIB)
    # frozen_string_literal: true

    class #{filename.camelcase}
      def initialize(input)
        @input = input
      end

      def part1
        true
      end

      def part2
        true
      end
    end
  LIB
end

test_file = "./#{year}/test/#{day}.rb"
unless File.exist?(test_file)
  File.write(test_file, <<~TEST)
    # frozen_string_literal: true

    require 'minitest/autorun'
    require_relative('../lib/#{day}_#{filename}')

    describe #{filename.camelcase} do
      let(:described_class) { #{filename.camelcase} }
      let(:input) { <<~INPUT }
      INPUT

      def test_part1
        assert_equal true, described_class.new(input).part1
      end

      def test_part2
        assert_equal true, described_class.new(input).part2
      end
    end
  TEST
end

`$EDITOR #{lib_file} #{test_file}`
