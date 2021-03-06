require 'rails_helper'

RSpec.describe Question, type: :model do
  # validation
  it { should validate_presence_of(:smatex) }
  it { should validate_presence_of(:latex) }
  it { should validate_presence_of(:question_type) }
  it { should validate_presence_of(:ans_smatex) }
  it { should validate_presence_of(:ans_latex) }

  # relation
  it { should belong_to(:exam) }
  it { should have_many(:results).dependent(:destroy) }
end
