Rails.application.routes.draw do
  namespace :v1 do
    # teacher client's resource routing
    with_options(except: %i[new edit], shallow: true, format: 'json') do |opt|
      opt.resources :teachers do
        opt.resources :exams do
          opt.resources :questions
        end
      end
    end

    # non-RESTful routings 'Result'
    get  'exams/:exam_id/results', to: 'results#index', as: 'exam_results'
    post 'results', to: 'results#create'

    post 'auth/teacher/login', to: 'auth#teacher_login'
    post 'exams/:id/open',  to: 'exams#open',  as: 'exam_open'
    post 'exams/:id/close', to: 'exams#close', as: 'exam_close'

    # student client's resource routing
    get 'rooms/:room_id/questions',     to: 'room#questions_index', as: 'room_questions'
    get 'rooms/:room_id/questions/:id', to: 'room#questions_show',  as: 'room_question_single'
  end
end
