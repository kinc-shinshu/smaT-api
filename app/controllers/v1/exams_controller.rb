class V1::ExamsController < ApplicationController
  def index
    room = Exam.all
    render json: room
  end

  def show
  end

  def create
    teacher = Teacher.find(params[:teacher_id])
    exam = teacher.exams.create!(title: params[:title], status: 1)
    json_response(exam, :created)
  end

  def edit
  end

  def update
    exam = Exam.find(params[:id])
    exam.update!(title: params[:title])
    json_response(exam)
  end

  def destroy
    exam = Exam.find(params[:id])
    exam.destroy
    json_response({}, :no_content)
  end
end
