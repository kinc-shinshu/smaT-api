require 'rails_helper'

RSpec.describe State, type: :model do
  it { should validate_presence_of(:client_id) }
  it { should validate_presence_of(:q_id) }
  it { should validate_presence_of(:judge) }
  it { should validate_presence_of(:challenge) }
end
