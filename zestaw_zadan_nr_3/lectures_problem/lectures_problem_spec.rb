# frozen_string_literal: true

require_relative 'lectures_problem'

describe LecturesProblem do
  describe '.find_maximum_amount_of_lectures' do
    context 'when values are given by teacher' do
      let(:wishes) do
        [{ start_time: 1, end_time: 2, duration: 1 }, { start_time: 3, end_time: 5, duration: 2 },
         { start_time: 0, end_time: 4, duration: 4 }, { start_time: 6, end_time: 8, duration: 2 },
         { start_time: 7, end_time: 13, duration: 6 }, { start_time: 4, end_time: 6, duration: 2 },
         { start_time: 9, end_time: 10, duration: 1 }, { start_time: 9, end_time: 12, duration: 3 },
         { start_time: 11, end_time: 14, duration: 3 }, { start_time: 15, end_time: 19, duration: 4 },
         { start_time: 14, end_time: 16, duration: 2 }, { start_time: 18, end_time: 20, duration: 2 }]
      end
      it 'should return maximum amount of lecture hours' do
        expect(LecturesProblem.find_maximum_amount_of_lectures(wishes:)).to eq(16)
      end
    end

    context 'when values are created by me' do
      let(:wishes) do
        [{ start_time: 1, end_time: 3, duration: 2 }, { start_time: 2, end_time: 5, duration: 3 },
         { start_time: 4, end_time: 6, duration: 2 }, { start_time: 6, end_time: 7, duration: 1 },
         { start_time: 5, end_time: 8, duration: 3 }, { start_time: 7, end_time: 9, duration: 2 }]
      end
      it 'should return maximum amount of lecture hours' do
        expect(LecturesProblem.find_maximum_amount_of_lectures(wishes:)).to eq(7)
      end
    end
  end
end
