# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/04_secure_container')

class SecureContainerTest < Minitest::Test
  def described_class = SecureContainer

  def test_part1
    assert_equal 1, described_class.new('122345-122345').part1
    assert_equal 0, described_class.new('223450-223450').part1
    assert_equal 0, described_class.new('123789-123789').part1
  end

  def test_part2
    assert_equal 1, described_class.new('112233-112233').part2
    assert_equal 0, described_class.new('123444-123444').part2
    assert_equal 1, described_class.new('111122-111122').part2
  end
end
