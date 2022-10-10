# frozen_string_literal: true

# Damian Richter PS10 Algorytmy i Struktury Danych
# Dwumian Newtona
# tools used to develop:
# WSL2 with VScode using VScode server
# no additionals libraries were used to make counting etc. easier :)
# debugger
# require 'byebug'

class ErrorHandler
  class NumberGreaterOrEqualToZero < StandardError
    def message
      'One or both of the numbers are negative'
    end
  end

  class NumberNotAnIntegerError < StandardError
    def message
      'One or both of the numbers are not integers'
    end
  end

  class SecondNumberWrongValue < StandardError
    def message
      'Second number must be less or equal to 10000'
    end
  end

  class SecondNumberGreaterThanFirst < StandardError
    def message
      'Second number must be less or equal to first'
    end
  end

  def self.handle_error(n, m)
    raise NumberGreaterOrEqualToZero unless n >= 0 && m >= 0
    raise NumberNotAnIntegerError unless n.integer? && m.integer?
    raise SecondNumberWrongValue if m > 10_000
    raise SecondNumberGreaterThanFirst if m > n
  end
end

module BinomialCoefficient
  # naive approach
  # Time Complexity: O(2^n)
  # Space Complexity: O(k)
  def recursive(n, m)
    # checking whether initial conditions are right
    ErrorHandler.handle_error(n, m)

    return 1 if m.zero? || n == m

    recursive(n - 1, m - 1) + recursive(n - 1, m)
  end

  # dynamic programming
  # when using pattern it access already allocated memory unlike recursion
  # Time complexity: O(n * k)
  # Space complexity: k
  def dynamic_programming(n, m)
    # checking whether initial conditions are right
    ErrorHandler.handle_error(n, m)

    arr = Array.new(n + 1) { Array.new(m + 1, 0) }

    (0..n).each do |i|
      (0..(i < m ? i : m)).each do |j|
        arr[i][j] = if j.zero? || i == j
                      1
                    else
                      arr[i - 1][j - 1] + arr[i - 1][j]
                    end
      end
    end

    # returning the value
    arr[n][m]
  end
end

class TestBinomialCoefficient
  include BinomialCoefficient

  def calc
    f = File.new('out_A_1_Richter.txt', 'w')

    File.readlines('in_A_1_Richter.txt').each do |line|
      n = line.split(' ').map(&:to_i).first
      m = line.split(' ').map(&:to_i).last

      f.puts dynamic_programming(n, m)
      f.puts recursive(n, m)

    rescue ErrorHandler::NumberGreaterOrEqualToZero => e
      f.puts "Error: #{e.message}."
    rescue ErrorHandler::NumberNotAnIntegerError => e
      f.puts "Error: #{e.message}."
    rescue ErrorHandler::SecondNumberWrongValue => e
      f.puts "Error: #{e.message}."
    rescue ErrorHandler::SecondNumberGreaterThanFirst => e
      f.puts "Erorr: #{e.message}."
    end
  end
end

# TestBinomialCoefficient.new.calc
