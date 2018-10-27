require 'rails_helper'

RSpec.describe 'Teachers API', type: :request do
  describe 'POST /teachers' do
    context 'when request is valid' do
      let(:valid_params) { { fullname: 'John Henecy', username: 'john_h', password_digest: '5f4dcc3b5aa765d61d8327deb882cf99' } }
      before { post '/teachers', params: valid_params }

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
end
