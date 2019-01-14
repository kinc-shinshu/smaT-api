class V1::RoomController < ApplicationController
  before_action :validate_question_index, only: :questions_show

  def questions_index
    @questions = Exam.where(status: 1).find_by!(room_id: params[:room_id]).questions.order(:id)
    render 'v1/questions/index'
  end

  def questions_show
    questions = Exam.where(status: 1).find_by!(room_id: params[:room_id]).questions.order(:id)
    @question = questions[params[:id].to_i - 1]
    if @question.nil?
      render json: { message: 'Question does not found.' }, status: :not_found
    else
      render 'v1/questions/show'
    end
  end

  private

  def validate_question_index
    json_response({ message: 'Invalid request.' }, :bad_request) unless params[:id].to_i.positive?
  end
end
