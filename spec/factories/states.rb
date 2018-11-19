FactoryBot.define do
  factory :state do
    student_id { 1 }
    q_id { '1' }
    judge { '0' }
    challenge { '1' }

    # example
    factory :finished_state do
      student_id { 777 }
      q_id { '1,2,3,4,5,6,7,8,9' }
      judge { '1,0,0,1,1,0,0,1,1' }
      challenge { '1,4,3,3,1,1,1,4,2' }
    end
  end
end
