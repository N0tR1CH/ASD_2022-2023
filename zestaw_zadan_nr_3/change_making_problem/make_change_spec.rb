# frozen_string_literal: true

require_relative 'make_change'

describe MakeChangeProblem do
  describe '.dynamic_programming' do
    let(:coins) { [2, 3, 5] }
    let(:limits) { { 2 => 2, 3 => 2, 5 => 1 } }
    let(:amount) { 10 }
    let(:result) { [1, 1, 1] }

    it 'should return amount of certain coins used to withdraw money' do
      expect(MakeChangeProblem.dynamic_programming(coins, limits, amount)).to eq(result)
    end
  end
end
