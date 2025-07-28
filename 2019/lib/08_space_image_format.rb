# frozen_string_literal: true

class SpaceImageFormat
  def initialize(input)
    @input = input.strip
  end

  def part1(height = 6, width = 25)
    layers = @input.chars.each_slice(height * width).to_a
    layer = layers.min_by { |l| l.count('0') }
    layer.count('1') * layer.count('2')
  end

  def part2(height = 6, width = 25)
    layers = @input.chars.each_slice(height * width).to_a
    image = [nil] * (height * width)
    (0...(height * width)).each do |i|
      layers.each do |lay|
        if lay[i] != '2'
          image[i] = lay[i]
          break
        end
      end
    end
    image.each_slice(width).to_a.map(&:join).join("\n").tr('10', '# ')
  end
end
