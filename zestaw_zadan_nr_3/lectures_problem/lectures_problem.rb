# frozen_string_literal: true

# Namespace with methods for lectures scheduling problem
module LecturesProblem
  class << self
    def create_a_hash_manually(lecturer_number_of_wishes:)
      wishes = []
      lecturer_number_of_wishes.times do
        start_time = gets.to_i
        end_time = gets.to_i
        duration = (end_time - start_time).abs
        wishes.push({ start_time: start_time, end_time: end_time, duration: duration })
      end
      wishes
    end

    def create_a_hash_from_a_file(file_name:)
      wishes = []
      File.foreach(file_name) do |line|
        numbers = line.scan(/\d+/).collect!(&:to_i)
        start_time = numbers.first
        end_time = numbers.last
        duration = (end_time - start_time).abs
        wishes.push({ start_time: start_time, end_time: end_time, duration: duration })
      end
      wishes
    end

    def find_maximum_amount_of_lectures(wishes:)

    end
  end
end
