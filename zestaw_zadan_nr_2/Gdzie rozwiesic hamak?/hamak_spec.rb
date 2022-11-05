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
