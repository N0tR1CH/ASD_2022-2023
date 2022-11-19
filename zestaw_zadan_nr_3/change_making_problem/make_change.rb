# frozen_string_literal: true

require 'byebug'

# Class for methods that solve making a change problem
class MakeChangeProblem
  INFINITY = Float::INFINITY

  class << self
    def dynamic_programming(coins, limits, amount)
      table = begin_a_table(amount)
      counter = begin_a_hash_counter(amount, coins)
      coins.reverse_each do |coin|
        (0..(amount - coin)).each do |j|
          next unless table[j] < INFINITY && table[j] + 1 < table[j + coin]
          next if counter[j][coin] + 1 > limits[coin]

          table[j + coin] = table[j] + 1
          counter[j + coin] = counter[j].clone
          counter[j + coin][coin] += 1
        end
      end
      counter.last.values
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

  private_class_method %i[begin_a_table begin_a_hash_counter]
end
