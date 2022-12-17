# frozen_string_literal: true

# Zlozonosc obliczeniowa calego programu:

require 'byebug'

# Zlozonosc quick sort:
# O(n log n)
# Pesymistyczna -> O(n ^ 2)
def qsort(arr)
  return arr if arr.size < 2

  pivot = arr.first

  arr_less_than_pivot = arr.select { |element| element < pivot }
  arr_greater_than_pivot = arr.select { |element| element > pivot }

  qsort(arr_less_than_pivot) + ([pivot] * arr.count(arr.first)) + qsort(arr_greater_than_pivot)
end

def pick_median(arr, liczba_stacji)
  arr.size.even? ? arr[(liczba_stacji / 2) - 1] : arr[liczba_stacji / 2]
end

def optimize_shipment(liczba_stacji, stacje)
  hash = {}
  liczba_stacji.times.each { |i| hash[i] = stacje[i] }
  arr = qsort(hash.values)
  median = pick_median(arr, liczba_stacji)
  arr.delete(median)
  sum = find_sum_of_differences(arr, median)
  indeks_elementu = hash.key(median)
  return_results(indeks_elementu, sum)
end

def return_results(indeks_elementu, sum)
  results = Array.new(2, 0)
  results[0] = indeks_elementu
  results[1] = sum
  results
end

# O(n - 1)
def find_sum_of_differences(arr, median)
  sum = 0
  arr.each { |element| sum += (element - median).abs }
  sum
end

liczba_stacji = gets.chomp.to_i
stacje = Array.new(liczba_stacji)
liczba_stacji.times.each { |i| stacje[i] = gets.chomp.to_i }
#puts optimize_shipment(liczba_stacji, stacje)

