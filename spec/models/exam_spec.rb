require 'rails_helper'

RSpec.describe Exam, type: :model do
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:title) }

  # relation
  it { should belong_to(:teacher) }
  it { should have_many(:question) }
end
