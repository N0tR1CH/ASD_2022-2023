# frozen_string_literal: true

require 'byebug'
require 'deep_dup'
require 'deep_dup/core_ext/object'

class Object
  include DeepDup
end

def create_graph_from_filename(filename)
  graph = {}
  street_number_counter = 1

  File.readlines(filename).each do |line|
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

  graph
end

def eulerian_circuit(graph)
  # Create a stack to hold the circuit
  circuit = []

  # Create a copy of the graph to modify as we traverse it
  graph_copy = graph.deep_dup

  # Choose an arbitrary starting vertex
  start_vertex = graph_copy.keys.first

  # Create a stack to hold the vertices in the current path
  path = [start_vertex]

  # Keep track of the current vertex
  current_vertex = start_vertex

  # While there are still vertices in the path
  until path.empty?
    # Get the next vertex to visit
    next_vertex = get_next_vertex(graph_copy, current_vertex)

    # If there is a vertex to visit
    if next_vertex
      # Add it to the path
      path << next_vertex

      # Update the current vertex
      current_vertex = next_vertex
    else
      # If there is no vertex to visit, we have reached a dead end
      # so we backtrack by removing the last vertex from the path
      # and adding it to the circuit
      circuit << path.pop
      current_vertex = path.last
    end
  end

  # Return the circuit
  circuit
end

# This helper method returns the next vertex to visit
# given the current vertex and the graph
def get_next_vertex(graph, vertex)
  # Get the edges for the vertex
  edges = graph[vertex]

  # If there are no edges, return nil
  return nil if edges.empty?

  # Otherwise, choose an edge at random
  edge = edges.sample

  # Remove the edge from the graph
  graph[vertex] = edges - [edge]

  # Return the neighbor vertex
  edge.keys.first
end

graph = create_graph_from_filename('zwi.in.txt')
graph_copy = graph.deep_dup
circuit = eulerian_circuit(graph_copy)

byebug

puts "chuj"