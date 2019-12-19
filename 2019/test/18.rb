require 'minitest/autorun'
require_relative('../lib/18_many_worlds_interpretation.rb')

describe ManyWorldsInterpretation do
  before { @k = ManyWorldsInterpretation }

  def test_cycle
    assert_equal false, @k.new('
#########
#b.A.@.a#
#########').has_cycle?

    assert_equal true, @k.new('
#####
# @ #
# # #
#   #
#####').has_cycle?
  end

  def test_part1
    assert_equal 8, @k.new('
#########
#b.A.@.a#
#########').part1
  end

  def test_part1_b
    assert_equal 86, @k.new('
########################
#f.D.E.e.C.b.A.@.a.B.c.#
######################.#
#d.....................#
########################').part1
  end

  def test_part1_c
    assert_equal 132, @k.new('
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################').part1
  end

  def test_part1_d
    assert_equal 136, @k.new('
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################').part1
  end

  def test_part1_e
    assert_equal 81, @k.new('
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################').part1
  end

  def test_part2
    assert_equal 8, @k.new('
#######
#a.#Cd#
##...##
##.@.##
##...##
#cB#Ab#
#######').part2
  end

  def test_part2_b
    assert_equal 32, @k.new('
#############
#DcBa.#.GhKl#
#.###...#I###
#e#d#.@.#j#k#
###C#...###J#
#fEbA.#.FgHi#
#############').part2
  end

  def test_part2_c
    assert_equal 72, @k.new('
#############
#g#f.D#..h#l#
#F###e#E###.#
#dCba...BcIJ#
#####.@.#####
#nK.L...G...#
#M###N#H###.#
#o#m..#i#jk.#
#############').part2
  end
end
