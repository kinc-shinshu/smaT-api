class Exam < ApplicationRecord
  # callback
  before_validation :set_status
  after_initialize  :set_default

  # validation
  validates_presence_of :title

  # relation
  belongs_to :teacher
  has_many :questions, dependent: :destroy

  private

  def set_status
    self.status ||= 0
  end

  def set_default
    self.room_id = -1
  end
end
