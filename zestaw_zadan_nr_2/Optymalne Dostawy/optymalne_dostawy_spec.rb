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
    let(:arr) { [7, 2, 2, 5, 6] }
    let(:sorted_arr) { [2, 2, 5, 6, 7] }

    it 'should sort an array' do
      expect(qsort(arr)).to eq(sorted_arr)
    end
  end

  context 'when it is already sorted' do
    let(:arr) { [1, 2, 3, 4, 5, 6] }

    it 'should return array with same values' do
      expect(qsort(arr)).to eq(arr)
    end
  end
end

describe '#pick_median' do
  context 'when it receives even number of elements in array' do
    let(:arr) { [1, 2, 3, 4, 5, 6] }
    let(:liczba_stacji) { 6 }

    it 'should return element before middle one' do
      expect(pick_median(arr, liczba_stacji)).to eq(3)
    end
  end

  context 'when it receives odd number of elements in array' do
    let(:arr) { [1, 2, 3, 4, 5, 6, 7] }
    let(:liczba_stacji) { 7 }

    it 'should return element right in the middle' do
      expect(pick_median(arr, liczba_stacji)).to eq(4)
    end
  end
end

describe '#optimize_shipment' do
  let(:liczba_stacji) { 3 }
  let(:stacje) { [10, 4, 8] }
  let(:results) { [2, 6]}

  it 'should return array with results' do
    expect(optimize_shipment(liczba_stacji, stacje)).to eq(results)
  end
end

describe '#find_sum_of_differences' do
  let(:arr) { [10, 4] }
  let(:median) { 8 }
  let(:result) { 6 }

  it 'should return result of the summing' do
    expect(find_sum_of_differences(arr, median)).to eq(result)
  end
end
