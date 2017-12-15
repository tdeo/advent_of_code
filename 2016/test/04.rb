require 'minitest/autorun'
require_relative('../lib/04_security.rb')

describe Security do
  before { @k = Security }

  def test_part1_1
    assert_equal 1514, @k.new('aaaaa-bbb-z-y-x-123[abxyz]
      a-b-c-d-e-f-g-h-987[abcde]
      not-a-real-room-404[oarel]
      totally-real-room-200[decoy]').part1
  end
end
