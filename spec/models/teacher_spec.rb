require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }

  # relation
  it { should have_many(:exam) }
end
