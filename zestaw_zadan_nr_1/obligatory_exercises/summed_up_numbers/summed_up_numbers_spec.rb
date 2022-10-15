# frozen_string_literal: true

require 'rspec'
require_relative 'summed_up_numbers'

describe FirstApproach do
  let(:first_arr) { [2, 3, 4, 4, 5, 1, 3, 2, 5, 4] }
  let(:second_arr) { [1, 2, 3] }
  describe '#summing_up_numbers' do
    it { expect(FirstApproach.summing_up_numbers(first_arr)).to eq(4) }
    it { expect(FirstApproach.summing_up_numbers(second_arr)).to eq(3) }
  end
end

describe SecondApproach do
  let(:first_arr) { [2, 3, 4, 4, 5, 1, 3, 2, 5, 4] }
  let(:second_arr) { [1, 2, 3] }
  describe '#summing_up_numbers' do
    it { expect(SecondApproach.summing_up_numbers(first_arr)).to eq(4) }
    it { expect(SecondApproach.summing_up_numbers(second_arr)).to eq(3) }
  end
end
