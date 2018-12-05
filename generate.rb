#! /usr/bin/env ruby

require 'pathname'
require 'active_support/core_ext/string'

dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir dir

unless ARGV.size == 3 && ARGV[0] =~ /\d+/ && ARGV[1] =~ /\d+/
  puts 'Usage: ./generate.rb <year> <problem number> <name>'
  exit 1
end

year = ARGV[0]
day = ARGV[1].to_s.rjust(2, '0')
filename = ARGV[2].underscore

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
