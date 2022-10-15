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

module FirstApproach
  # module_function makes method self

  module_function

  def summing_up_numbers(a)
    until a.uniq?
      sum = a.first
      a.shift
      unless a.find_index(sum).nil?
        a.delete_at(a.find_index(sum))
        sum += sum
      end
      a.push(sum)
    end

    # returning an array size
    a.size
  end
end

module SecondApproach
  module_function

  def summing_up_numbers(a)
    if a.uniq?
      a.size
    else
      sum = a.first
      a.shift
      unless a.find_index(sum).nil?
        a.delete_at(a.find_index(sum))
        sum += sum
      end
      a.push(sum)
      summing_up_numbers(a)
    end
  end
end

n = gets.chomp.to_i
a = []

n.times { a << gets.chomp.to_i }

# puts "First approach gives length of: #{FirstApproach.summing_up_numbers(a)}."
puts "Second approach gives length of: #{SecondApproach.summing_up_numbers(a)}."
