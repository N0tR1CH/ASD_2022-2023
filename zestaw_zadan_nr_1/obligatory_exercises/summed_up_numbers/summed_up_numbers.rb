# frozen_string_literal: true

# adding method to an array class that checks uniqueness of array elements
class Array
  def uniq?
    # at first it was just 'self == uniq' but I wanted to make it more 'mine' instead
    # of relying on function built in standard ruby library
    number_counts = {}

    each do |number|
      return false if number_counts[number]

      number_counts[number] = 1 unless number_counts[number]
    end

    true
  end
end

# first approach uses iterations to achieve final condition
module FirstApproach
  # module_function makes method self

  module_function

  def summing_up_numbers(arr)
    until arr.uniq?
      sum = arr.first
      arr.shift
      unless arr.find_index(sum).nil?
        arr.delete_at(arr.find_index(sum))
        sum += sum
      end
      arr.push(sum)
    end

    # returning an array size
    arr.size
  end
end

# second approach uses recursion to achieve final condition
module SecondApproach
  module_function

  def summing_up_numbers(arr)
    if arr.uniq? then arr.size
    else
      sum = arr.first
      arr.shift
      unless arr.find_index(sum).nil?
        arr.delete_at(arr.find_index(sum))
        sum += sum
      end
      arr.push(sum)
      summing_up_numbers(arr)
    end
  end
end

n = gets.chomp.to_i
a = []

n.times { a << gets.chomp.to_i }

# puts "First approach gives length of: #{FirstApproach.summing_up_numbers(a)}."
puts "Second approach gives length of: #{SecondApproach.summing_up_numbers(a)}."
