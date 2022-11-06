# frozen_string_literal: true

require_relative 'point'
require_relative 'integer'
require 'byebug'

module ClosestPairOfPoints
  class << self
    def brute_force(points)
      point1 = point2 = Point.new(0, 0)
      min_distance = Integer::MAX
      points.size.times.each do |i|
        (i + 1..points.size - 1).each do |j|
          distance = Point.distance_between_points(points[i], points[j])
          next if min_distance <= distance

          min_distance = distance
          point1 = points[i]
          point2 = points[j]
        end
      end
      [point1, point2, min_distance]
    end

    def recursion(points_sorted_by_x, points_sorted_by_y)
      number_of_points = points_sorted_by_x.size
      return brute_force(points_sorted_by_x) if number_of_points <= 3

    end

    def find_closest_pair_of_points(points)
      points_sorted_by_x = points.sort_by(&:x)
      points_sorted_by_y = points.sort_by(&:y)
      recursion(points_sorted_by_x, points_sorted_by_y)
    end
  end
end

coordinates = [Point.new(4, 4),
               Point.new(0, 0),
               Point.new(3, 3),
               Point.new(3, 1),
               Point.new(1, 1)]

puts ClosestPairOfPoints.brute_force(coordinates)
