#! /usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require 'fileutils'
require 'pathname'
require 'active_support/core_ext/string'
require 'sorbet-runtime'

dir = T.must(__dir__)
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
  FileUtils.mkdir_p(File.dirname(lib_file))
  File.write(lib_file, <<~LIB)
    # typed: strong
    # frozen_string_literal: true

    require 'sorbet-runtime'

    class #{filename.camelcase}
      extend T::Sig

      sig { params(input: String).void }
      def initialize(input)
        @input = input
      end

      sig { returns(Integer) }
      def part1
        0
      end

      sig { returns(Integer) }
      def part2
        0
      end
    end
  LIB
end

test_file = "./#{year}/test/#{day}.rb"
unless File.exist?(test_file)
  FileUtils.mkdir_p(File.dirname(test_file))
  File.write(test_file, <<~TEST)
    # typed: strict
    # frozen_string_literal: true

    require 'sorbet-runtime'
    require 'minitest/autorun'
    require_relative('../lib/#{day}_#{filename}')

    class #{filename.camelcase}Test < Minitest::Spec
      extend T::Sig
      sig { returns(T.class_of(#{filename.camelcase})) }
      def described_class = #{filename.camelcase}

      sig { returns(String) }
      def input = <<~INPUT
      INPUT

      sig { void }
      def test_part1
        assert_equal nil, described_class.new(input).part1
      end

      sig { void }
      def test_part2
        assert_equal nil, described_class.new(input).part2
      end
    end
  TEST
end

`git add -N #{lib_file} #{test_file}`
`timeout 1 $EDITOR #{lib_file} #{test_file}`
