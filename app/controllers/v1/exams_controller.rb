class V1::ExamsController < ApplicationController
  def index
    room = Exam.all
    render json: room
  end

  def show
  end

  def create
    room = Exam.find_by(status: 0)
    if room.nil?
      render status: :forbidden
    else
      room.update(title: params[:title], status: 1)
      render json: room
    end
  end

  def edit
  end

  def update
  end

  def destroy
    close_room_id = params[:id]
    room = Exam.find(close_room_id)
    room.questions.where(room_id: close_room_id).destroy_all
    room.update(title: 'title', status: 0)
    render json: room
  end
end
