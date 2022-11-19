# frozen_string_literal: true

require 'byebug'
require_relative 'make_change'

# Liczba monet
coins_count = gets.chomp.to_i
# Monety
coins = []
coins_count.times { coins << gets.chomp.to_i }
# Ilosc monet
limits = Hash[coins.map { |key| [key, gets.chomp.to_i] }]
# Kwota do wyplacenia
amount = gets.chomp.to_i
# Reszta
change = MakeChangeProblem.dynamic_programming(coins, limits, amount)
# Odpowiedz
# Ilosc monet czyli suma liczb w tabicy change
print "#{change.sum}\n"
# F.E. 1 1 1 bo bierzemy monety 2 3 5
change.each { |element| print "#{element} " }
