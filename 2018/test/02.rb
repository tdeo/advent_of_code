# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_inventory_management_system')

describe InventoryManagementSystem do
  before { @k = InventoryManagementSystem }

  def test_part1
    assert_equal 12, @k.new('abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab').part1
  end

  def test_part2
    assert_equal 'fgij', @k.new('abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz').part2
  end
end
