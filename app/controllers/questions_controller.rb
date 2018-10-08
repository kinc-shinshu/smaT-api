class QuestionsController < ApplicationController
  def index
    questions = Room.find(params[:room_id]).questions.all
    render json: questions
  end

  def create
    question = Room.find(params[:room_id]).questions.new(question_params)
    question.save
    render json: question
  end

  def destroy
    detele_question_id = params[:id]
    question = Room.find(params[:room_id]).questions.find(detele_question_id).destroy
    render json: question
  end

  # そのままパラメータを渡すとRoom_idまで更新されて消えてしまうため
  # 更新の場合は必要なパラメータのみ渡す
  def update
    update_command_id = params[:id]
    question = Room.find(params[:room_id]).questions.find(update_command_id)
    question.update(question_params_for_update)
    render json: question
  end

  private
  def question_params
    question_text = params[:text]
    question_answer = params[:answer]
    question_room_id = :room_id
    {text: question_text, answer: question_answer, room_id: question_room_id}
  end

  # 更新の場合のパラメータ
  # 将来的にパラメータが増える可能性あるので一応定義した
  def question_params_for_update
    question_text = params[:text]
    question_answer = params[:answer]
    {text: question_text, answer: question_answer}
  end

end
