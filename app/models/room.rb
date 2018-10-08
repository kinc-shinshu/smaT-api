class Room < ApplicationRecord
  has_many :questions, dependent: :destroy
end
