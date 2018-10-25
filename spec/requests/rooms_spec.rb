require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /rooms" do
    before { get rooms_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
