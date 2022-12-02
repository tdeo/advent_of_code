# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/02_rock_paper_scissors')

describe RockPaperScissors do
  let(:described_class) { RockPaperScissors }
  let(:input) { <<~INPUT }
    A Y
    B X
    C Z
  INPUT

  def test_part1
    assert_equal 15, described_class.new(input).part1
  end

  def test_part2
    assert_equal 12, described_class.new(input).part2
  end
end
