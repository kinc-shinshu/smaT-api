require 'rails_helper'

RSpec.describe 'Teachers', type: :request do
  describe 'POST /v1/teachers' do
    context 'when request is valid' do
      before { post v1_teachers_path, params: valid_params }
      let(:valid_params) do
        {
          fullname: 'John Henecy',
          username: 'john_h',
          password_digest: '5f4dcc3b5aa765d61d8327deb882cf99'
        }
      end
      let(:teacher) { Teacher.last }

      it 'shows created teacher detail only id, fullname' do
        expect(json['id']).to eq(teacher.id)
        expect(json['fullname']).to eq(teacher.fullname)
        # below things MUST NOT SHOW
        expect(json['username']).to be_nil
        expect(json['token']).to be_nil
        expect(json['password_digest']).to be_nil
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post v1_teachers_path, params: {} }

      it "shows 'Validation failed' message" do
        expect(json['message']).to match(/Validation failed/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  # this is test of authenticate
  describe 'GET /v1/teachers/:id' do
    let!(:teacher) { create(:teacher) }
    let(:id) { teacher.id }
    let(:token) { teacher.token }
    let(:headers) { { 'Authorization' => "Token #{token}" } }

    context 'when token is taken' do
      before { get v1_teacher_path(id), headers: headers }

      it 'can show teacher detail only id, fullname' do
        expect(json['id']).to eq(teacher.id)
        expect(json['fullname']).to eq(teacher.fullname)
        # belo things MUST NOT SHOW
        expect(json['username']).to be_nil
        expect(json['token']).to be_nil
        expect(json['password_digest']).to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when token is taken but id is invalid' do
      let(:id) { 0 }
      before { get v1_teacher_path(id), headers: headers }

      it 'shows error messages' do
        expect(json['message']).to match(/Couldn't find Teacher/)
      end

      it 'returns status 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when token is not taken' do
      before { get v1_teacher_path(id), headers: {} }

      it "shows 'Authentication required' message" do
        expect(json['message']).to match(/Authorization required/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
