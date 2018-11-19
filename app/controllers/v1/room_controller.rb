class V1::RoomController < ApplicationController
  before_action :validate_question_index, only: :questions_show

  def questions_index
    questions = Exam.where(status: 1).find_by!(room_id: params[:room_id]).questions
    json_response(questions)
  end

  def questions_show
    questions = Exam.find_by!(room_id: params[:room_id]).questions
    q = questions[params[:id].to_i - 1]
    if q.nil?
      json_response({ message: 'Question does not found.' }, :not_found)
    else
      json_response(q)
    end
  end

  private

  def validate_question_index
    json_response({ message: 'Invalid request.' }, :bad_request) unless params[:id].to_i.positive?
  end
end
