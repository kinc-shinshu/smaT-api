class TeachersController < ApplicationController
  before_action :authenticate, only: %i[show]

  # show dashboard...?
  def show
  end

  def create
    teacher = Teacher.create!(create_params)
    render json: teacher
  end

  private

  def create_params
    {
      fullname: params[:fullname],
      username: params[:username],
      password_digest: params[:password_digest]
    }
  end
end
