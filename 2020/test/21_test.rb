# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/21_allergen_assessment')

class AllergenAssessmentTest < Minitest::Test
  def described_class = AllergenAssessment

  def test_part1
    assert_equal 5, described_class.new(<<~INPUT).part1
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    INPUT
  end

  def test_part2
    assert_equal 'mxmxvkd,sqjhc,fvjkl', described_class.new(<<~INPUT).part2
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    INPUT
  end
end
