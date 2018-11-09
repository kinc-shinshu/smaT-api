require 'rails_helper'

RSpec.describe "States", type: :request do
  let(:state) { create(:state) }
  let(:student_id) { state.student_id }

  describe 'GET /v1/states/:student_id' do
    context 'when state is saved' do
      before { get v1_state_path(student_id) }

      it 'returns state which is specified by student_id' do
        expect(json).to eq(JSON.parse(state.to_json))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request is invalid' do
      before { get v1_state_path(0) }

      it 'returns "Couldn\'t find ..." message' do
        expect(json['message']).to match(/Couldn't find/)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST /v1/states/:student_id' do
    let(:valid_params) do
      {
        q_id: '1',
        judge: '0',
        challenge: '1'
      }
    end

    context 'when state found' do
      before { post v1_state_path(student_id), params: valid_params }

      it 'updates state' do
        s = State.find_by(student_id: student_id)
        expect(s.q_id).to eq(valid_params[:q_id])
        expect(s.judge).to eq(valid_params[:judge])
        expect(s.challenge).to eq(valid_params[:challenge])
      end

      it 'returns "Update success." message' do
        expect(json['message']).to eq('Update success.')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when state not found' do
      before { post v1_state_path(student_id + 1), params: valid_params }

      it 'creates new state' do
        s = State.find_by(student_id: student_id + 1)
        expect(s.q_id).to eq(valid_params[:q_id])
        expect(s.judge).to eq(valid_params[:judge])
        expect(s.challenge).to eq(valid_params[:challenge])
      end

      it 'returns "State created." message' do
        expect(json['message']).to eq('State created.')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'POST /v1/states/:student_id/finish' do
    context 'when state exists' do
      let(:state) { create(:finished_state) }
      let(:student_id) { state.student_id }
      before { post v1_states_finish_path(student_id) }

      # TODO: write assertion for creating result

      it 'returns "Finish." message' do
        expect(json['message']).to eq('Finish.')
      end

      it 'deletes specified state' do
        expect(State.find_by(student_id: student_id)).to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when state does not exist' do
      before { post v1_states_finish_path(student_id) }

      it 'returns "Couldn\'t find..." message' do
        expect(json['message']).to match(/Coludn't find/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
