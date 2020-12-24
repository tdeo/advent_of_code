require 'minitest/autorun'
require_relative('../lib/01_report_repair.rb')

describe ReportRepair do
  before { @k = ReportRepair }

  def test_part1
    assert_equal 514579, @k.new('1721
979
366
299
675
1456').part1
  end

  def test_part2
    assert_equal 241861950, @k.new('1721
979
366
299
675
1456').part2
  end
end
