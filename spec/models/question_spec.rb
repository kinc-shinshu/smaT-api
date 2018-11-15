require 'rails_helper'

RSpec.describe Question, type: :model do
  # validation
  it { should validate_presence_of(:smatex) }
  it { should validate_presence_of(:latex) }
  it { should validate_presence_of(:question_type) }
  it { should validate_presence_of(:answer) }

  # relation
  it { should belong_to(:exam) }
end
