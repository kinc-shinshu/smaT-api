class V1::StatesController < ApplicationController
  def show
    state = State.find_by!(student_id: params[:student_id])
    json_response(state)
  end

  # use state.valid? as validator to check state is saved in
  def update
    state = State.find_or_initialize_by(student_id: params[:student_id])
    message, code = state.valid? ? ['Update success.', :ok] : ['State created.', :created]
    state.update!(update_params)
    json_response({ message: message }, code)
  end

  def finish
    state = State.find_by!(student_id: params[:student_id])
    # TODO: write operation to create result
    state.delete
    json_response(message: 'Finish.')
  end

  private

  def update_params
    {
      q_id: params[:q_id],
      judge: params[:judge],
      challenge: params[:challenge]
    }
  end
end
