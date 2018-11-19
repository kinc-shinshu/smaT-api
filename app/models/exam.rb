class Exam < ApplicationRecord
  # callback
  after_initialize :set_default

  # validation
  validates_presence_of :title

  # relation
  belongs_to :teacher
  has_many :questions, dependent: :destroy

  private

  def set_default
    self.room_id = -1
    self.status ||= 0
  end
end
