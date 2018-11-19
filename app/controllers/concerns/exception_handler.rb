module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :bad_request
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :bad_request
    end

    rescue_from InvalidFormatError do |_|
      render json: { message: 'Invalid request format.' }, status: :bad_request
    end
  end
end
