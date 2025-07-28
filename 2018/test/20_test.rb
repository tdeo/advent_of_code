# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/20_a_regular_map')

class ARegularMapTest < Minitest::Test
  def described_class = ARegularMap

  def test_part1
    assert_equal 3, described_class.new('^WNE$').part1
  end

  def test_part1_2
    assert_equal 10, described_class.new('^ENWWW(NEEE|SSE(EE|N))$').part1
  end

  def test_part1_3
    assert_equal 18, described_class.new('^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$').part1
  end

  def test_part1_4
    assert_equal 23, described_class.new('^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$').part1
  end

  def test_part1_5
    assert_equal 31, described_class.new('^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$').part1
  end
end
