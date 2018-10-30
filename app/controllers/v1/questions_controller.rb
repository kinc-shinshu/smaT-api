class V1::QuestionsController < ApplicationController
  def index
    questions = Exam.find(params[:Exam_id]).questions.all
    render json: questions
  end

  def create
    question = Exam.find(params[:Exam_id]).questions.new(question_params)
    question.save
    render json: question
  end

  def destroy
    delete_question_id = params[:id]
    question = Exam.find(params[:Exam_id]).questions.find(delete_question_id).destroy
    render json: question
  end

  # そのままパラメータを渡すとExam_idまで更新されて消えてしまうため
  # 更新の場合は必要なパラメータのみ渡す
  def update
    update_command_id = params[:id]
    question = Exam.find(params[:Exam_id]).questions.find(update_command_id)
    question.update(question_params_for_update)
    render json: question
  end

  private

  # TODO: rewrite with params.require.permit
  def question_params
    question_text = params[:text]
    question_answer = params[:answer]
    question_type = params[:question_type]
    question_Exam_id = :Exam_id
    {text: question_text, answer: question_answer, question_type: question_type,Exam_id: question_Exam_id}
  end

  # 更新の場合のパラメータ
  # 将来的にパラメータが増える可能性あるので一応定義した
  # TODO: rewrite with params.require.permit
  #       if any params not specified, do not update it(dont replace as null)
  def question_params_for_update
    question_text = params[:text]
    question_answer = params[:answer]
    question_type = params[:question_type]
    {text: question_text, answer: question_answer, question_type: question_type}
  end
end
