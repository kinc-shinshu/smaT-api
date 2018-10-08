class RoomsController < ApplicationController

  def create
    room = Room.find_by(status: 0)
    if room.nil?
      render status: :forbidden
    elsif
      room.update(title:params[:title], name:room.name, status: 1)
      render json: room
    end
  end
end
