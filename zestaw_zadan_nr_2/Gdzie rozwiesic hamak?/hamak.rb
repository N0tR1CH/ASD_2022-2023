# frozen_string_literal: true

# Punkt
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "x: #{@x} y: #{@y}"
  end
end

# dystans pomiędzy dwoma punktami
def distance_between_points(point1, point2)
  Math.sqrt((point1.x - point2.x)**2 + (point1.y - point2.y)**2)
end

n = 5

coordinates = [Point.new(4, 4),
               Point.new(0, 0),
               Point.new(3, 3),
               Point.new(3, 1),
               Point.new(1, 1)]

coordinates.sort_by!(&:x)
