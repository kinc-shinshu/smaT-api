class V1::AuthController < ApplicationController
  def teacher_login
    teacher = Teacher.find_by!(username: params[:username], password_digest: params[:password_digest])
    render json: { token: teacher.token }, status: :ok
  end
end
