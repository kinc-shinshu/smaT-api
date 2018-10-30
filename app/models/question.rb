class Question < ApplicationRecord
  # validation
  validates_presence_of :text, :type, :answer

  # relation
  belongs_to :exam
end
