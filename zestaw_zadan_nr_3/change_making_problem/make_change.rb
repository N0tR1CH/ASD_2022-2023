# frozen_string_literal: true

require 'byebug'

class MakeChangeProblem
  INFINITY = Float::INFINITY

  class << self
    def dynamic_programming(coins, limits, amount)
      table = begin_a_table(amount)
      counter = begin_a_hash_counter(amount, coins)
    end

    def begin_a_table(amount)
      table = []
      (amount + 1).times { |i| table << (i.zero? ? 0 : INFINITY) }
      table
    end

    def begin_a_hash_counter(amount, coins)
      arr = []
      (amount + 1).times { arr << Hash[coins.map { |key| [key, 0] }] }
      arr
    end
  end

  private_class_method :begin_a_table, :begin_a_hash_counter
end
