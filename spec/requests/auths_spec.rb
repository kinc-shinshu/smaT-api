require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  let!(:teacher) { create(:teacher) }
  let(:username) { teacher.username }
  let(:password) { teacher.password_digest }
  let(:token) { teacher.token }

  describe 'POST /auth/teacher/login' do
    context 'when request is valid' do
      let(:valid_params) do
        { username: username, password_digest: password }
      end
      before { post '/auth/teacher/login', params: valid_params }

      it "responses teacher's token" do
        expect(json['token']).to eq(token)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { post '/auth/teacher/login', params: {} }
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
