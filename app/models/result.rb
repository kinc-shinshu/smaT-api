class Result < ApplicationRecord
  # validation
  validates_presence_of :judge, :challenge

  # relation
  belongs_to :question
end
