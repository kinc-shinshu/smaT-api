Rails.application.routes.draw do
  # resources :rooms, only: [:index, :create, :destroy] do
  #   resources :questions, only: [:index, :create, :destroy, :update]
  # end
  namespace :v1 do
    # teacher client's resource routing
    resources :teachers, only: %i[index show create update destroy], shallow: true do
      resources :exams,  only: %i[index show create update destroy], shallow: true do
        resources :questions, only: %i[index show create update destroy]
        resources :results,   only: %i[index show create update destroy]
      end
    end

    post 'auth/teacher/login', to: 'auth#teacher_login'

    # student client's resource routing
    get 'rooms/:room_id/questions',     to: 'room#questions_index', as: 'room_questions'
    get 'rooms/:room_id/questions/:id', to: 'room#questions_show',  as: 'room_question_single'

    get  'states/:client_id', to: 'states#show'
    post 'states/:client_id', to: 'states#update'
    get  'states/:client_id/finish', to: 'states#finish'
  end
end
