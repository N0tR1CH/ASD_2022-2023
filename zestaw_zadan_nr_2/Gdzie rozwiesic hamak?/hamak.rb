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

    def recurrence(points_sorted_by_x, points_sorted_by_y, points)
      # BASE CASES
      number_of_points = points_sorted_by_x.size
      return brute_force(points_sorted_by_x) if number_of_points <= 3

      # DIVIDE
      minimum_distance_left = recurrence(points_sorted_by_x[0...points_sorted_by_x.size / 2], points_sorted_by_y,
                                         points)
      minimum_distance_right = recurrence(points_sorted_by_x[points_sorted_by_x.size / 2...points_sorted_by_x.size],
                                          points_sorted_by_y, points)
      minimum_distance_overall = if minimum_distance_left[2] == minimum_distance_right[2]
                                   if check_which_one_was_first(minimum_distance_left[0..1],
                                                                minimum_distance_right[0..1], points) == 'left'
                                     minimum_distance_left
                                   else
                                     minimum_distance_right
                                   end
                                 end
      # COMBINE
    end

    def check_which_one_was_first(points_left, points_right, points)
      points.each do |point|
        return 'left' if points_left[0] == point || points_left[1] == point
        return 'right' if points_right[0] == point || points_right[1] == point
      end
    end

    def find_closest_pair_of_points(points)
      points_sorted_by_x = points.sort_by(&:x)
      points_sorted_by_y = points.sort_by(&:y)
      recurrence(points_sorted_by_x, points_sorted_by_y, points)
    end
  end
end

coordinates = [Point.new(4, 4),
               Point.new(0, 0),
               Point.new(3, 3),
               Point.new(3, 1),
               Point.new(1, 1)]

puts ClosestPairOfPoints.find_closest_pair_of_points(coordinates)
