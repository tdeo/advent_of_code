# frozen_string_literal: true

class AllergenAssessment
  def initialize(input)
    @input = input

    @allergens = {}
    @ingredients = {}
    @recipes = []

    @input.each_line do |recipe|
      allergens = recipe.match(/\(contains (.*)\)/)[1].split(',').map(&:strip)
      ingredients = recipe.split('(').first.split.map(&:strip)

      allergens.each { @allergens[_1] = nil }
      ingredients.each { @ingredients[_1] = nil }
      @recipes << { allergens: allergens, ingredients: ingredients }
    end

    find_all_matches
  end

  def find_match?
    @allergens.each_key do |allergen|
      next unless @allergens[allergen].nil?

      recipes = @recipes.select { |r| r[:allergens].include?(allergen) }

      options = recipes.map { _1[:ingredients] }.reduce(:&)
      options.select! { |o| @ingredients[o].nil? }

      next unless options.size == 1

      @ingredients[options[0]] = allergen
      @allergens[allergen] = options[0]
      return true
    end

    false
  end

  def find_all_matches
    loop { break unless find_match? }
  end

  def part1
    count = 0
    @recipes.each do |recipe|
      recipe[:ingredients].each do |ingredient|
        count += 1 if @ingredients[ingredient].nil?
      end
    end
    count
  end

  def part2
    @allergens.sort_by(&:first).map(&:last).join(',')
  end
end
