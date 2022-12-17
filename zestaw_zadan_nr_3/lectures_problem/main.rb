# frozen_string_literal: true

require_relative 'lectures_problem'

# Creating hash for storing the information about certain lectures
lecturer_number_of_wishes = gets.to_i
# Creating manually
wishes = LecturesProblem.create_a_hash_manually(lecturer_number_of_wishes: lecturer_number_of_wishes)
# Creating from a file
# wishes = LecturesProblem.create_a_hash_from_a_file(file_name: 'dane.txt')
# PURPOSE OF THIS TASK:
# Given certain lectures with start and end time and duration of them,
# find the maximum value you can make by scheduling lectures in non overlapping way
puts LecturesProblem.find_maximum_amount_of_lectures(wishes:)
