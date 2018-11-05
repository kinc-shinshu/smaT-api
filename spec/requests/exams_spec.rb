require 'rails_helper'

RSpec.describe 'Exams', type: :request do
  let(:teacher) { create(:teacher) }
  let(:teacher_id) { teacher.id }
  let(:exam) { teacher.exams.first }
  let(:exam_id) { exam.id }

  describe 'POST /v1/teachers/:teacher_id/exams' do
    context 'when request is valid' do
      let(:valid_params) { { title: 'Examination' } }
      before { post v1_teacher_exams_path(teacher_id), params: valid_params }

      it 'returns created exam' do
        expect(json['title']).to eq(valid_params[:title])
      end

      it 'creates "open" exam' do
        expect(json['status']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params not specified invalid' do
      before { post v1_teacher_exams_path(teacher_id), params: {} }

      it 'returns "Validation failed" message' do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when teacher does not found' do
      let(:teacher_id) { 0 }
      before { post v1_teacher_exams_path(teacher_id), params: {} }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find .../)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'PATCH/PUT /v1/exams/:id' do
    context 'when request is valid' do
      let(:valid_params) { { title: 'New Examination' } }
      before { put v1_exam_path(exam_id), params: valid_params }

      it 'returns updated exam' do
        expect(json['title']).to eq(valid_params[:title])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when params not specified invalid' do
      before { put v1_exam_path(exam_id), params: {} }

      it 'returns "Validation failed" message' do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when exam not found' do
      let(:exam_id) { 0 }
      before { put v1_exam_path(exam_id), params: {} }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE /v1/exams/:id' do
    let(:question) { exam.questions.first }
    let(:question_id) { question.id }

    context 'when exam found' do
      before { delete v1_exam_path(exam_id) }

      it 'deletes exam' do
        expect(Exam.find_by(id: exam_id)).to be_nil
      end

      it 'deletes question related exam' do
        expect(question).to be_nil
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when exam not found' do
      let(:exam_id) { 0 }
      before { delete v1_exam_path(exam_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
