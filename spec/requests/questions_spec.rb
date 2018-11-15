require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:teacher) { create(:teacher) }
  let(:exam) { teacher.exams.first }
  let(:exam_id) { exam.id }
  let(:questions) { exam.questions }
  let(:question) { questions.first }
  let(:question_id) { question.id }

  describe 'GET /v1/exams/:exam_id/questions' do
    context 'when exam exists' do
      before { get v1_exam_questions_path(exam_id) }

      # questions is ActiveRecord::CollectionProxy
      it 'returns all questions of exam' do
        expect(json).to eq(JSON.parse(questions.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam does not exist' do
      let(:exam_id) { 0 }
      before { get v1_exam_questions_path(exam_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end
    end
  end

  describe 'POST /v1/exams/:exam_id/questions' do
    context 'when request is valid' do
      let(:valid_params) { { smatex: '#{4}', latex: '\sqrt{4}', answer: '2', question_type: 'Math' } }
      before { post v1_exam_questions_path(exam_id), params: valid_params }

      it 'returns created question' do
        expect(json['smatex']).to eq(valid_params[:smatex])
        expect(json['latex']).to eq(valid_params[:latex])
        expect(json['answer']).to eq(valid_params[:answer])
        expect(json['question_type']).to eq(valid_params[:question_type])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post v1_exam_questions_path(exam_id), params: {} }

      it 'returns "Validation failed" message' do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/questions/:id' do
    context 'when question exists' do
      before { get v1_question_path(question_id) }

      it 'returns specified question' do
        expect(json).to eq(JSON.parse(question.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when question does not exist' do
      let(:question_id) { 0 }
      before { get v1_question_path(question_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'PATCH/PUT /v1/questions/:id' do
    context 'when request is valid' do
      let(:valid_params) { { smatex: '#{2}', latex: '\sqrt{2}', answer: '1.41421356', question_type: 'Mathematics' } }
      before { put v1_question_path(question_id), params: valid_params }

      it 'returns updated question' do
        expect(json['smatex']).to eq(valid_params[:smatex])
        expect(json['latex']).to eq(valid_params[:latex])
        expect(json['answer']).to eq(valid_params[:answer])
        expect(json['question_type']).to eq(valid_params[:question_type])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { put v1_question_path(question_id), params: {} }

      it 'returns "Validation failed" message' do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE /v1/questions/:id' do
    context 'when question exists' do
      before { delete v1_question_path(question_id) }

      it 'deletes question' do
        expect(Question.find_by(id: question_id)).to be_nil
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when question does not exist' do
      before { delete v1_question_path(0) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
