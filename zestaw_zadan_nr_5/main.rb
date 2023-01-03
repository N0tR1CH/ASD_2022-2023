# frozen_string_literal: true

require 'byebug'
require 'deep_dup'

graph = {}
street_number_counter = 1

File.readlines('zwi.in.txt').each do |line|
  line_output = line.split
  if line_output.count == 1
    amount_of_intersections = line_output.first.to_i
    (1..amount_of_intersections).each { |i| graph[i] = [] }
    next
  else
    line_output.map!(&:to_i)
    graph[line_output.first] << { line_output[1] => { length: line_output[2], interest_rate: line_output[3],
                                                      street_number: street_number_counter } }
    graph[line_output[1]] << { line_output.first => { length: line_output[2], interest_rate: line_output[3],
                                                      street_number: street_number_counter } }
    street_number_counter += 1
  end
end

byebug

puts "chuj"