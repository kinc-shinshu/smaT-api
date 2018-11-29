require 'rails_helper'

RSpec.describe 'Exams', type: :request do
  let(:teacher) { create(:teacher) }
  let(:teacher_id) { teacher.id }
  let(:exams) { teacher.exams }
  let(:exam) { exams.first }
  let(:exam_id) { exam.id }

  describe 'GET /v1/exams/:id' do
    context 'when exam exists' do
      before { get v1_exam_path(exam_id) }

      it 'returns specified exam' do
        expect(json).to eq(JSON.parse(exam.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam does not exist' do
      let(:exam_id) { 0 }
      before { get v1_exam_path(exam_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/teachers/:teacher_id/exams' do
    context 'when teacher exists' do
      before { get v1_teacher_exams_path(teacher_id) }

      it 'returns all exams created by specified teacher' do
        expect(json).to eq(JSON.parse(exams.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when teacher does not exist' do
      let(:teacher_id) { 0 }
      before { get v1_teacher_exams_path(teacher_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST /v1/teachers/:teacher_id/exams' do
    context 'when request is valid' do
      let(:valid_params) { { title: 'Examination', description: Faker::Lorem.sentence } }
      before { post v1_teacher_exams_path(teacher_id), params: valid_params }

      it 'returns created exam' do
        expect(json['title']).to eq(valid_params[:title])
        expect(json['description']).to eq(valid_params[:description])
      end

      it 'creates "close" exam' do
        expect(json['status']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is valid (if description doesn\'t provide)' do
      let(:valid_params) { { title: 'No Description Exam' } }
      before { post v1_teacher_exams_path(teacher_id), params: valid_params }

      it 'returns created exam' do
        expect(json['title']).to eq(valid_params[:title])
        expect(json['description']).to eq('')
      end

      it 'creates "close" exam' do
        expect(json['status']).to eq(0)
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
      let(:valid_params) { { title: 'New Examination', description: "New #{Faker::Lorem.sentence}" } }
      before { put v1_exam_path(exam_id), params: valid_params }

      it 'returns updated exam' do
        expect(json['title']).to eq(valid_params[:title])
        expect(json['description']).to eq(valid_params[:description])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when params not specified or invalid' do
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

  describe 'POST /v1/exams/:id/open' do
    context 'when exam exists' do
      let(:close_exam) { create(:close_exam) }
      let(:exam_id) { close_exam.id }
      before { post v1_exam_open_path(exam_id) }

      it 'assigns room_id to specified exam' do
        expect(json['room_id']).not_to eq(-1)
      end

      it 'updates status to 1' do
        expect(json['status']).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam is already opened' do
      let(:open_exam) { create(:open_exam) }
      let(:exam_id) { open_exam.id }
      before { post v1_exam_open_path(exam_id) }

      it "returns 'Couldn't find ...' (open exam) message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when exam not found' do
      let(:exam_id) { 0 }
      before { post v1_exam_open_path(exam_id) }

      it "returns 'Couldn't find ...' message" do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST /v1/exams/:id/close' do
    context 'when exam exists' do
      before { post v1_exam_close_path(exam_id) }

      it 'assigns room_id = -1 to specified exam' do
        expect(json['room_id']).to eq(-1)
      end

      it 'updates status to 0' do
        expect(json['status']).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when exam not found' do
      let(:exam_id) { 0 }
      before { post v1_exam_close_path(exam_id) }

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
