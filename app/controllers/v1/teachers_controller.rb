class V1::TeachersController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate, only: %i[show]

  # show dashboard...?
  def show
    teacher = Teacher.find(params[:id])
    json_response(teacher.to_safe_response)
  end

  def create
    teacher = Teacher.create!(create_params)
    json_response(teacher.to_safe_response)
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
      teacher = Teacher.find_by!(token: token)
      !teacher.nil?
    end
  end

  def render_unauthorized
    json_response({ message: 'Authorization required' }, :unauthorized)
  end

  def authenticate
    authenticate_token || render_unauthorized
  end
end
