# spec/optymalne_dostawy_spec.rb

require 'spec_helper'
require 'rspec'
require_relative 'optymalne_dostawy'
require 'byebug'

describe '#qsort' do
  context 'when without duplications' do
    let(:arr) { [9, -3, 5, 2, 6, 8, -6, 1, 3] }
    let(:sorted_arr) { [-6, -3, 1, 2, 3, 5, 6, 8, 9] }

    it 'should sort an array' do
      expect(qsort(arr)).to eq(sorted_arr)
    end
  end

  context 'when with duplications' do
    let(:arr) { [7, 2, 2, 5, 6]}
    let(:sorted_arr) { [2, 2, 5, 6, 7] }

    it 'should sort an array' do
      expect(qsort(arr)).to eq(sorted_arr)
    end
  end
end
