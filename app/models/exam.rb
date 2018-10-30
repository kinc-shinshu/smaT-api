class Exam < ApplicationRecord
  # callback
  before_validation :set_status

  # validation
  validates_presence_of :title

  # relation
  belongs_to :teacher
  has_many :questions, dependent: :destroy

  private

  def set_status
    self.status ||= 0
  end
end
