class V1::ResultsController < ApplicationController
  # show all results which is selected exam with question
  def index
    exam = Exam.find(params[:exam_id])
    @questions = exam.questions.includes(:results)
  end

  # def show
  #   # write for student in future
  # end

  def create
    Result.transaction do
      restrict_empty_request
      q_id, judge, challenge = parse_result_params
      restrict_invalid_request(q_id, judge, challenge)
      q_id.each_with_index do |id, i|
        Result.create!(
          judge: judge[i],
          challenge: challenge[i],
          question: Question.find(id)
        )
      end
    end
    render json: { message: 'Results submitted.' }, status: :created
  end

  def destroy; end

  private

  def parse_result_params
    [
      params[:q_id].split(',').map(&:to_i),
      params[:j].split(',').map(&:to_i),
      params[:c].split(',').map(&:to_i)
    ]
  end

  def restrict_empty_request
    raise InvalidFormatError if params[:q_id].nil? || params[:j].nil? || params[:c].nil?
  end

  def restrict_invalid_request(q_id, judge, challenge)
    raise InvalidFormatError unless q_id.size == judge.size && q_id.size == challenge.size && judge.size == challenge.size
  end
end
