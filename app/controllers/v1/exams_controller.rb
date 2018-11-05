class V1::ExamsController < ApplicationController
  def index
    room = Exam.all
    render json: room
  end

  def show
    exam = Exam.find(params[:id])
    json_response(exam)
  end

  def create
    teacher = Teacher.find(params[:teacher_id])
    exam = teacher.exams.create!(title: params[:title], status: 1)
    json_response(exam, :created)
  end

  def update
    exam = Exam.find(params[:id])
    exam.update!(title: params[:title])
    json_response(exam)
  end

  def destroy
    Exam.find(params[:id]).destroy
    json_response({}, :no_content)
  end
end
