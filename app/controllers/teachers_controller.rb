class TeachersController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate, only: %i[show]

  # show dashboard...?
  def show
    render json: @teacher
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

  def authenticate_token
    authenticate_with_http_token do |token, _|
      @teacher = Teacher.find_by!(token: token)
      !@teacher.nil?
    end
  end

  def render_unauthorized
    render json: { message: 'Authentication required' }, status: :unauthorized
  end

  def authenticate
    authenticate_token || render_unauthorized
  end
end
