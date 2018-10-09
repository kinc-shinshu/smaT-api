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
      room.update(title: params[:title], name: room.name, status: 1)
      render json: room
    end
  end

  def destroy
    close_room_id = params[:id]
    room = Room.find(close_room_id)
    room.update(title: 'title', name: 'name', status: 0)
    render json: room
  end
end
