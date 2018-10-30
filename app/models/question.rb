class Question < ApplicationRecord
  # validation
  validates_presence_of :text, :question_type, :answer

  # relation
  belongs_to :exam
end
