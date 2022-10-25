# frozen_string_literal: true

def qsort(arr)
  return arr if arr.size < 2

  pivot = arr.first
  arr.delete(arr.first)

  arr_less_than_pivot = arr.select { |element| element < pivot }
  arr_greater_than_pivot = arr.select { |element| element > pivot }

  qsort(arr_less_than_pivot) + [pivot] + qsort(arr_greater_than_pivot)
end

# hash to store values of distances with its indexes
hash = {}

# variable to store number of stations
liczba_stacji = gets.chomp.to_i

# loop to get values into the hash
liczba_stacji.times.each { |i| hash[i] = gets.chomp.to_i }

# getting sorted array form hash values
arr = qsort(hash.values)

# getting the median
median = arr[liczba_stacji / 2]

# deleting median
arr.delete(median)

# counting sum of differences
sum = 0
arr.each { |element| sum += (element - median).abs }

# getting element index
indeks_elementu = hash.key(median)

# result
puts indeks_elementu
puts sum
