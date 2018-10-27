require 'rails_helper'

RSpec.describe 'Teachers API', type: :request do
  describe 'POST /teachers' do
    context 'when request is valid' do
      before { post '/teachers', params: valid_params }
      let(:valid_params) do
        {
          fullname: 'John Henecy',
          username: 'john_h',
          password_digest: '5f4dcc3b5aa765d61d8327deb882cf99'
        }
      end

      it 'creates a new teacher' do
        expect(json['fullname']).to eq('John Henecy')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { post '/teachers', params: {} }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  # this is test of authenticate
  describe 'GET /teachers/:id' do
    context 'when token is taken' do
      let!(:teacher) { create(:teacher) }
      let(:id) { teacher.id }
      let(:token) { teacher.token }
      let(:headers) { { 'Authorization' => "Token #{token}" } }
      before { get "/teachers/#{id}", headers: headers }

      it 'shows teacher detail' do
        expect(json).to eq(teacher.to_json)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when token is not taken' do
      it "shows 'Authentication required' message" do
        expect(response.body).to match(/Authentication required/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
