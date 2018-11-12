Rails.application.routes.draw do
  namespace :v1 do
    # teacher client's resource routing
    with_options(except: %i[new edit]) do |opt|
      opt.resources :teachers, shallow: true do
        opt.resources :exams, shallow: true do
          opt.resources :questions
          opt.resources :results
        end
      end
    end

    post 'auth/teacher/login', to: 'auth#teacher_login'
    post 'exams/:id/open',  to: 'exams#open',  as: 'exam_open'
    post 'exams/:id/close', to: 'exams#close', as: 'exam_close'

    # student client's resource routing
    get 'rooms/:room_id/questions',     to: 'room#questions_index', as: 'room_questions'
    get 'rooms/:room_id/questions/:id', to: 'room#questions_show',  as: 'room_question_single'

    get  'states/:student_id', to: 'states#show', as: 'state'
    post 'states/:student_id', to: 'states#update'
    post 'states/:student_id/finish', to: 'states#finish', as: 'state_finish'
  end
end
