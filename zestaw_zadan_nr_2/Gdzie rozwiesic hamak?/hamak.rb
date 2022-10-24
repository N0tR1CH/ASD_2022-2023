# frozen_string_literal: true

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "x: #{@x} y: #{@y}"
  end
end

arr = [Point.new(4, 4),
       Point.new(0, 0),
       Point.new(3, 3),
       Point.new(3, 1),
       Point.new(1, 1)]

arr.sort_by!(&:x)

puts arr
