require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:teacher) { create(:teacher) }
  let(:exam) { teacher.exams.first }
  let(:exam_id) { exam.id }
  let(:questions) { exam.questions }
  let(:question_id) { questions.first.id }

  describe 'GET /v1/exams/:exam_id/questions' do
    context 'when exam exists' do
      before { get v1_exam_questions_path(exam_id) }

      it 'returns all questions of exam' do
        expect(json['questions']).to eq(questions)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam does not exist' do
      let(:exam_id) { 0 }
      before { get v1_exam_questions_path(exam_id) }

      it 'returns "Record Not Found" message' do
        expect(json['message']).to match(/Record Not Found/)
      end
    end
  end

  describe 'POST /v1/exams/:exam_id/questions' do
    context 'when request is valid' do
      let(:valid_params) { { text: '4+4=', answer: '8', question_type: 'Math' } }
      before { post v1_exam_questions_path(exam_id), params: valid_params }

      it 'returns created question' do
        expect(json['question_type']).to eq(valid_params[:question_type])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post v1_exam_questions_path(exam_id), params: {} }

      it 'returns "Request Invalid" message' do
        expect(json['message']).to match(/Request Invalid/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'PATCH/PUT /v1/questions/:id' do
    context 'when request is valid' do
      let(:valid_params) { { text: '8+8=', answer: '16', question_type: 'Mathematics' } }
      before { put v1_question_path(question_id), params: valid_params }

      it 'returns updated question' do
        expect(json['question_type']).to eq(valid_params[:question_type])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { put v1_question_path(question_id), params: {} }
      it 'returns "Request Invalid" message' do
        expect(json['message']).to match(/Request Invalid/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE /v1/questions/:id' do
    context 'when question exists' do
    end

    context 'when question does not exist' do
      it 'returns "Request Invalid" message' do
        expect(json['message']).to match(/Request Invalid/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
