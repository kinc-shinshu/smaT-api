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
    get 'room/:id/questions', to: 'room#questions', as: 'room_questions'
  end
end
