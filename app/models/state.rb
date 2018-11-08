class State < ApplicationRecord
  validates_presence_of :student_id, :q_id, :judge, :challenge
end
