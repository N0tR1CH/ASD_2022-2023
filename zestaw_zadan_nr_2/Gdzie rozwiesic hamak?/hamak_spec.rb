# frozen_string_literal: true

# spec/hamak_spec.rb

require 'spec_helper'
require 'rspec'
require_relative 'hamak'
require 'byebug'

describe Point do
  let(:first_point) { described_class.new(2, 2) }
  let(:second_point) { described_class.new(3, 3) }

  describe '.distance_between_points' do
    let(:result) { 1.4142135623730951 }

    it 'should calculate distance between two points' do
      expect(Point.distance_between_points(first_point, second_point)).to eq(result)
    end
  end

  describe '#to_s' do
    it 'should return object content in more clear way' do
      expect(first_point.to_s).to eq('x: 2 y: 2')
      expect(second_point.to_s).to eq('x: 3 y: 3')
    end
  end
end

describe ClosestPairOfPoints do
  let(:coordinates) do
    [Point.new(4, 4),
     Point.new(0, 0),
     Point.new(3, 3),
     Point.new(3, 1),
     Point.new(1, 1)]
  end
  let(:points_sorted_by_x) do
    [Point.new(0, 0),
     Point.new(1, 1),
     Point.new(3, 3),
     Point.new(3, 1),
     Point.new(4, 4)]
  end
  let(:points_sorted_by_y) do
    [Point.new(0, 0),
     Point.new(3, 1),
     Point.new(1, 1),
     Point.new(3, 3),
     Point.new(4, 4)]
  end

  describe '.brute_force' do
    let(:distance) { 1.4142135623730951 }

    it 'should return two points and their distance where it is minimal' do
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include('@x=4, @y=4')
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include('@x=3, @y=3')
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include(distance.to_s)
    end
  end

  describe '.find_closest_pair_of_points' do
    it 'should assign point_sorted_by_x' do
      expect(coordinates.sort_by(&:x)).to eq(points_sorted_by_x)
    end

    it 'should assign point_sorted_by_y' do
      expect(coordinates.sort_by(&:y)).to eq(points_sorted_by_y)
    end
  end

  describe '.recurrence' do
    context 'coordinates from task' do
      it 'should return points with minimum distance' do
        expect(ClosestPairOfPoints.recurrence(points_sorted_by_x, points_sorted_by_y,
                                              coordinates)).to include("3 3\n4 4")
      end
    end

    context 'two coordinates' do
      let(:coordinates) do
        [Point.new(4, 4),
         Point.new(1, 1)]
      end
      let(:points_sorted_by_x) do
        [Point.new(1, 1),
         Point.new(4, 4)]
      end
      let(:points_sorted_by_y) do
        [Point.new(1, 1),
         Point.new(4, 4)]
      end
      it 'should return points with minimum distance' do
        expect(ClosestPairOfPoints.recurrence(points_sorted_by_x, points_sorted_by_y,
                                              coordinates)).to include("1 4\n1 4")
      end
    end
  end
end
