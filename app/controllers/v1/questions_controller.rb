class V1::QuestionsController < ApplicationController
  def index
    questions = Exam.find(params[:exam_id]).questions
    json_response(questions)
  end

  def show
  end

  def create
    exam = Exam.find(params[:exam_id])
    question = exam.questions.create!(question_params)
    json_response(question, :created)
  end

  def update
    question = Question.find(params[:id])
    question.update!(question_params)
    json_response(question)
  end

  def destroy
    Question.find(params[:id]).destroy
    json_response({}, :no_content)
  end

  private

  def question_params
    {
      text: params[:text],
      answer: params[:answer],
      question_type: params[:question_type]
    }
  end
end
