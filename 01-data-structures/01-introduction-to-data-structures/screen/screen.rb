require_relative 'pixel'

class Screen
  attr_accessor :width, :height, :matrix

  def initialize(width, height)
    @width, @height= width, height
    self.matrix = Array.new(height){Array.new(width)}
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    return "Enter valid position" if inbounds?(x, y)
    matrix[x][y] = pixel
  end

  def at(x, y)
    return nil if inbounds?(x, y)
    matrix[x][y]
  end

  private

  def inbounds?(x, y)
    if (x < 0 || y < 0)
      true
    end
  end

end
