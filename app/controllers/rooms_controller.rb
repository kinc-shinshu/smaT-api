class RoomsController < ApplicationController

  def index
    room = Room.all
    render json: room
  end

  def create
    room = Room.find_by(status: 0)
    if room.nil?
      render status: :forbidden
    elsif
      room.update(title: params[:title], status: 1)
      render json: room
    end
  end

  def destroy
    close_room_id = params[:id]
    room = Room.find(close_room_id)
    room.questions.where(room_id: close_room_id).destroy_all
    room.update(title: 'title', status: 0)
    render json: room
  end

end
