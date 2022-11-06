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
  describe '.brute_force' do
    let(:coordinates) do
      [Point.new(4, 4),
       Point.new(0, 0),
       Point.new(3, 3),
       Point.new(3, 1),
       Point.new(1, 1)]
    end
    let(:distance) { 1.4142135623730951 }

    it 'should return two points and their distance where it is minimal' do
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include('@x=4, @y=4')
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include('@x=3, @y=3')
      expect(ClosestPairOfPoints.brute_force(coordinates).to_s).to include(distance.to_s)
    end
  end
end
