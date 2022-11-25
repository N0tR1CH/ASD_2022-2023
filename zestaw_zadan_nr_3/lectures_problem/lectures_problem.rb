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
      # Sorting lectures by ending time
      sort_by_finish_time(wishes)
      # Creating an array containing durations
      durations = init_durations(wishes)
      # Loop through lectures and find maximum amount of non overlapping lectures
      (1...wishes.size).each do |i|
        (0...wishes.size).each do |j|
          break if does_lectures_overlap?(wishes[i], wishes[j])
          next if i == j

          durations[i] = durations[j] + wishes[i][:duration] if durations[i] < (durations[j] + wishes[i][:duration])
        end
      end
      durations.max
    end

    def sort_by_finish_time(wishes)
      wishes.sort_by! { |lecture| lecture[:end_time] }
    end

    def does_lectures_overlap?(first_lecture, second_lecture)
      (first_lecture[:start_time] < second_lecture[:end_time]) &&
        (first_lecture[:end_time] > second_lecture[:start_time])
    end

    def init_durations(wishes)
      arr = []
      wishes.each { |wish| arr.push(wish[:duration]) }
      arr
    end
  end
  private_class_method %i[sort_by_finish_time does_lectures_overlap? init_durations]
end
