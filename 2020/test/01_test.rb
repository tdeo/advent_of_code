# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_report_repair')

class ReportRepairTest < Minitest::Test
  def described_class = ReportRepair

  def test_part1
    assert_equal 514_579, described_class.new('1721
979
366
299
675
1456').part1
  end

  def test_part2
    assert_equal 241_861_950, described_class.new('1721
979
366
299
675
1456').part2
  end
end
