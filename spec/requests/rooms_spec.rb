require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:open_exam) { create(:open_exam) }
  let(:open_exam_number) { open_exam.room_id }
  let(:close_exam) { create(:close_exam) }
  let(:close_exam_number) { close_exam.room_id }

  describe 'GET /v1/rooms/:room_id/questions' do
    context 'when room(opend exam) exists' do
      before { get v1_room_questions_path(open_exam_number) }

      it 'returns all questions from Exam.find_by(room_id: params[:room_id])' do
        binding.pry
        expect(response.body).to eq(open_exam.questions.to_json)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when room does not open' do
      before { get v1_room_questions_path(close_exam_number) }

      it "returns 'Couldn't find...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when room does not exist' do
      before { get v1_room_questions_path(0) }

      it "returns 'Couldn't find...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/rooms/:room_id/questions/:id' do
    context 'when question exists(id: 1)' do
      before { get v1_room_question_single_path(room_id: open_exam_number, id: 1) }

      it 'returns first question in exam' do
        expect(json).to eq(JSON.parse(open_exam.questions.first.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when question does not exist' do
      before { get v1_room_question_single_path(room_id: open_exam_number, id: 0) }

      it 'returns "Question does not found." message' do
        expect(json['message']).to eq("Question does not found.")
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
