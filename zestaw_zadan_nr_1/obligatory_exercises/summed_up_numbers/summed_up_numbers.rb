# adding method to an array class that checks uniqueness of array elements
class Array
  def uniq?
    self == self.uniq
  end
end

module FirstApproach
  # module_function makes method self
  module_function

  def summing_up_numbers(a)
    until a.uniq? do
      sum = a.first; a.shift
      unless a.find_index(sum).nil?
        a.delete_at(a.find_index(sum))
        sum += sum; a.push(sum)
        next
      end

      a.push(sum)

      next
    end

    # returning an array size
    a.size
  end
end

n = gets.chomp.to_i
a = []

n.times { a << gets.chomp.to_i }

puts "First approach gives length of: #{FirstApproach.summing_up_numbers(a)}."
