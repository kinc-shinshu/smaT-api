FactoryBot.define do
  factory :exam do
    title { "MyString" }
    status { 1 }
    room_number { 1 }
    teacher { nil }
  end
end
