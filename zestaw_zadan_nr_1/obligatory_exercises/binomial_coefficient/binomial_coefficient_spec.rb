# frozen_string_literal: true

require 'rspec'
require_relative 'binomial_coefficient'

RSpec.describe BinomialCoefficient do
  let(:dummy_class) { Class.new { extend BinomialCoefficient } }

  describe '#recursive' do
    it { expect(dummy_class.recursive(1, 0)).to eq(1) }
    it { expect(dummy_class.recursive(1, 1)).to eq(1) }
    it { expect(dummy_class.recursive(10, 2)).to eq(45) }
    it { expect(dummy_class.recursive(100, 3)).to eq(161_700) }
  end

  describe '#dynamic_programming' do
    it { expect(dummy_class.dynamic_programming(1, 0)).to eq(1) }
    it { expect(dummy_class.dynamic_programming(1, 1)).to eq(1) }
    it { expect(dummy_class.dynamic_programming(10, 2)).to eq(45) }
    it { expect(dummy_class.dynamic_programming(100, 3)).to eq(161_700) }
    it { expect(dummy_class.dynamic_programming(1000, 4)).to eq(41_417_124_750) }
  end
end
