class Teacher < ApplicationRecord
  has_secure_token
  validates_presence_of :fullname, :username, :password_digest
end
