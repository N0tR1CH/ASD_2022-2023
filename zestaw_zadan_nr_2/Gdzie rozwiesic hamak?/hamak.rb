# frozen_string_literal: true

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

def closest_pair(coordinates_sorted_by_x, _coordinates_sorted_by_y)
  number_of_points = coordinates_sorted_by_x.size

  # BASE CASES
  case number_of_points
  when 2
    return "#{coordinates_sorted_by_x[0]}\n#{coordinates_sorted_by_x[1]}"
  when 3
    result = [
      Point.distance_between_points(coordinates_sorted_by_x[0], coordinates_sorted_by_x[1]),
      Point.distance_between_points(coordinates_sorted_by_x[1], coordinates_sorted_by_x[2]),
      Point.distance_between_points(coordinates_sorted_by_x[0], coordinates_sorted_by_x[2])
    ].each_with_index.min

    case result[1]
    when 0
      return "#{coordinates_sorted_by_x[0]}\n#{coordinates_sorted_by_x[1]}"
    when 1
      return "#{coordinates_sorted_by_x[1]}\n#{coordinates_sorted_by_x[2]}"
    when 2
      return "#{coordinates_sorted_by_x[0]}\n#{coordinates_sorted_by_x[2]}"
    end
  end

  # DIVIDE

end

coordinates = [Point.new(4, 4),
               Point.new(0, 0),
               Point.new(3, 3),
               Point.new(3, 1),
               Point.new(1, 1)]

puts closest_pair(coordinates.sort_by(&:x), coordinates.sort_by(&:y))
# @coordinates_sorted_by_y = coordinates.sort_by!(&:y)
