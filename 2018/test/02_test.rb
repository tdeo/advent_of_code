# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_inventory_management_system')

class InventoryManagementSystemTest < Minitest::Test
  def described_class = InventoryManagementSystem

  def test_part1
    assert_equal 12, described_class.new('abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab').part1
  end

  def test_part2
    assert_equal 'fgij', described_class.new('abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz').part2
  end
end
