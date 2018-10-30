FactoryBot.define do
  factory :question do
    text { Faker::Lorem.sentence }
    answer { Faker::Lorem.sentence }
    type { Faker::Lorem.words }

    # belongs_to
    exam
  end

  factory :exam do
    title { Faker::Lorem.word }
    status { [0, 1].sample }
    room_id { rand(100..999) }

    # belongs_to
    teacher

    after(:create) do |exam, _|
      create_list(:question, 10, exam: exam)
    end
  end

  factory :teacher do
    fullname { Faker::Name.name }
    username { Faker::Internet.username }
    password_digest { '5f4dcc3b5aa765d61d8327deb882cf99' } # 'password'
    token { 'aGVsbG93b3JsZA==' } # Base64.encode64('helloworld').chomp

    after(:create) do |teacher, _|
      create_list(:exam, 1, teacher: teacher)
    end
  end
end
