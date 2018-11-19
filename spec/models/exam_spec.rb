require 'rails_helper'

RSpec.describe Exam, type: :model do
  # validation
  it { should validate_presence_of(:title) }

  # relation
  it { should belong_to(:teacher) }
  it { should have_many(:questions).dependent(:destroy) }
end
