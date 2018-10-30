require 'rails_helper'

RSpec.describe Question, type: :model do
  # validation
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:answer) }

  # relation
  it { should belong_to(:exam) }
end
