class V1::QuestionsController < ApplicationController
  def index
    @questions = Exam.find(params[:exam_id]).questions.order(:id)
    render status: :ok
  end

  def show
    @question = Question.find(params[:id])
    render status: :ok
  end

  def create
    exam = Exam.find(params[:exam_id])
    @question = exam.questions.create!(question_params)
    render :show, status: :created
  end

  def update
    @question = Question.find(params[:id])
    @question.update!(question_params)
    render :show
  end

  def destroy
    Question.find(params[:id]).destroy
    head :no_content
  end

  private

  def question_params
    {
      smatex: params[:smatex],
      latex: params[:latex],
      ans_smatex: params[:ans_smatex],
      ans_latex: params[:ans_latex],
      question_type: params[:question_type]
    }
  end
end
