require 'rails_helper'

RSpec.describe 'Results API', type: :request do
  let(:exam) { create(:exam) }
  let(:exam_id) { exam.id }
  let!(:questions) { exam.questions }
  let(:question) { questions.first }
  let(:question_id) { question.id }

  describe 'POST /results' do
    context 'when request is valid' do
      let(:valid_params) do
        {
          q_id: '1,2,3,4',
          j: '0,0,1,0',
          c: '3,1,5,9'
        }
      end
      before { post v1_results_path, params: valid_params }

      it 'creates many results specified by "q_id"' do
        expect(Result.all.count).to eq(4)
      end

      it 'returns "submitted" message' do
        expect(json['message']).to eq('Results submitted.')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is empty' do
      before { post v1_results_path, params: {} }

      it 'returns "Validation failed" message' do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when request\'s format is invalid' do
      let(:invalid_params) do
        {
          q_id: '1,2,34',
          j: '0',
          c: '3,15,'
        }
      end

      it 'returns "Invalid request format" message' do
        expect(json['message']).to eq('Invalid request format.')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/exams/:exam_id/results' do
    context 'when exam exists' do
      before { get v1_exam_results_path(exam_id) }
      it 'returns all results through its questions' do
        expect(json).to eq(JSON.parse(exam.questions.includes(:results).to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam does not exist' do
      let(:exam_id) { 0 }
      before { get v1_exam_results_path(exam_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/questions/:question_id/results' do
    context 'when question exists' do
      before { get v1_question_results_path(question_id) }
      it 'returns all results through its questions' do
        expect(json).to eq(JSON.parse(question.results.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when question does not exist' do
      let(:question_id) { 0 }
      before { get v1_question_results_path(question_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
