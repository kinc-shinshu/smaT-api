require 'rails_helper'

RSpec.describe Result, type: :model do
  # validation
  it { should validate_presence_of(:judge) }
  it { should validate_presence_of(:challenge) }

  # relation
  it { should belong_to(:question) }
end
