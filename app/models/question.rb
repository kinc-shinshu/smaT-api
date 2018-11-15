class Question < ApplicationRecord
  # validation
  validates_presence_of :smatex, :latex, :question_type, :answer

  # relation
  belongs_to :exam
end
