class Teacher < ApplicationRecord
  has_secure_token

  # validation
  validates_presence_of :fullname, :username, :password_digest

  # relation
  # which is better; delete exams when teacher deleted
  #                  save exams even though teacher deleted
  has_many :exams, dependent: :destroy
end
