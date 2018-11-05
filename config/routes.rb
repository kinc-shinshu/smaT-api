Rails.application.routes.draw do
  # resources :rooms, only: [:index, :create, :destroy] do
  #   resources :questions, only: [:index, :create, :destroy, :update]
  # end
  namespace :v1 do
    # teacher client's resource routing
    resources :teachers, shallow: true do
      resources :exams, shallow: true do
        resources :questions
        resources :results, only: %i[index create update destroy]
      end
    end

    post 'auth/teacher/login', to: 'auth#teacher_login'

    # student client's resource routing
    get 'rooms/:room_id/questions',     to: 'room#questions_index', as: 'room_questions'
    get 'rooms/:room_id/questions/:id', to: 'room#quesions_show',   as: 'room_question_single'

    get  'states/:client_id', to: 'states#show'
    post 'states/:client_id', to: 'states#update'
    get  'states/:client_id/finish', to: 'states#finish'
  end
end
