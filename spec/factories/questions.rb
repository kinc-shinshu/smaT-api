FactoryBot.define do
  factory :question do
    text { "MyString" }
    type { "" }
    answer { "MyString" }
    exam { nil }
  end
end
