class V1::ExamsController < ApplicationController
  ROOM_ID_GROUP = (100..999).to_a.freeze

  def index
    teacher = Teacher.find(params[:teacher_id])
    @exams = teacher.exams.order(:id)
    render status: :ok
  end

  def show
    @exam = Exam.find(params[:id])
    render status: :ok
  end

  def create
    teacher = Teacher.find(params[:teacher_id])
    @exam = teacher.exams.create!(exam_params)
    render :show, status: :created
  end

  def update
    @exam = Exam.find(params[:id])
    @exam.update!(exam_params)
    render :show
  end

  def destroy
    Exam.find(params[:id]).destroy
    json_response({}, :no_content)
  end

  # status: 0 means closed(not open) exam
  # if exam was nil when find by id with status: 0, it means specified exam is open
  # then rescue from ActiveRecord::RecordNotFound
  def open
    @exam = Exam.where(status: 0).find(params[:id])
    active_room_ids = Exam.where(status: 1).all.map(&:room_id)
    new_room_id = (ROOM_ID_GROUP - active_room_ids).sample
    @exam.update!(status: 1, room_id: new_room_id)
    render :show
  end

  def close
    @exam = Exam.find(params[:id])
    @exam.update!(status: 0, room_id: -1)
    render :show
  end

  private

  def exam_params
    {
      title: params[:title],
      description: params[:description]
    }
  end
end
