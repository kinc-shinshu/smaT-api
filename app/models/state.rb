class State < ApplicationRecord
  validates_presence_of :client_id, :q_id, :judge, :challenge
end
