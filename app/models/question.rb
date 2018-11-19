class Question < ApplicationRecord
  # validation
  validates_presence_of :smatex, :latex, :question_type, :ans_smatex, :ans_latex

  # relation
  belongs_to :exam
end
