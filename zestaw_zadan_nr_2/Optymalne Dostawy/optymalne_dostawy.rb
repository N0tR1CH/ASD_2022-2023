station_distances = Hash.new

n = 3

(n.times).each { |i| station_distances[i] = gets.chomp.to_i }

p station_distances

station_distances.sort_by { |key, value| value }.to_h