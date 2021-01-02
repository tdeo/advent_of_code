# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_noise')

describe Noise do
  before { @k = Noise }

  def test_part1
    assert_equal 'easter', @k.new('eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar').part1
  end

  def test_part2
    assert_equal 'advent', @k.new('eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar').part2
  end
end
