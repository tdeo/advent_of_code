require 'minitest/autorun'
require_relative('../lib/21_allergen_assessment.rb')

describe AllergenAssessment do
  before { @k = AllergenAssessment }

  def test_part1
    assert_equal 5, @k.new(<<~INPUT).part1
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    INPUT
  end

  def test_part2
    assert_equal 'mxmxvkd,sqjhc,fvjkl', @k.new(<<~INPUT).part2
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    INPUT
  end
end
