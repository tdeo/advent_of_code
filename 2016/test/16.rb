require 'minitest/autorun'
require_relative('../lib/16_dragon_checksum.rb')

describe DragonChecksum do
  before { @k = DragonChecksum }

  def test_demo
    assert_equal '01100', @k.new('10000').demo
  end
end
