# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/16_dragon_checksum')

class DragonChecksumTest < Minitest::Test
  def described_class = DragonChecksum

  def test_demo
    assert_equal '01100', described_class.new('10000').demo
  end
end
