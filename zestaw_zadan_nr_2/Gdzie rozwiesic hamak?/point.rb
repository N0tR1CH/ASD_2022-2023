# Punkt
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.distance_between_points(point1, point2)
    Math.sqrt((point1.x - point2.x)**2 + (point1.y - point2.y)**2)
  end

  def to_s
    "x: #{@x} y: #{@y}"
  end
end