# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/20_a_regular_map')

describe ARegularMap do
  before { @k = ARegularMap }

  def test_part1
    assert_equal 3, @k.new('^WNE$').part1
  end

  def test_part1_2
    assert_equal 10, @k.new('^ENWWW(NEEE|SSE(EE|N))$').part1
  end

  def test_part1_3
    assert_equal 18, @k.new('^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$').part1
  end

  def test_part1_4
    assert_equal 23, @k.new('^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$').part1
  end

  def test_part1_5
    assert_equal 31, @k.new('^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$').part1
  end
end
