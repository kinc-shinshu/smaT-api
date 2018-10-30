module Response
  def json_response(body, status = :ok)
    render json: body, status: status
  end
end
