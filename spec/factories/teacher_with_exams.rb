FactoryBot.define do
  factory :result do
    judge { [0, 1].sample }
    challenge { rand(1..5) }

    # belongs_to
    question
  end

  factory :question do
    smatex { Faker::Lorem.sentence }
    latex  { Faker::Lorem.sentence }
    ans_smatex { Faker::Lorem.sentence }
    ans_latex  { Faker::Lorem.sentence }
    question_type { Faker::Lorem.word }

    # belongs_to
    exam

    after(:create) do |question, _|
      create_list(:result, 5, question: question)
    end
  end

  factory :exam do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status { [0, 1].sample }
    room_id { rand(100..999) }

    # belongs_to
    teacher

    after(:create) do |exam, _|
      create_list(:question, 10, exam: exam)
    end

    factory :open_exam do
      title { 'Open Exam' }
      status { 1 }
      room_id { 100 }
    end

    factory :close_exam do
      title { 'Close Exam' }
      status { 0 }
      room_id { 999 }
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
