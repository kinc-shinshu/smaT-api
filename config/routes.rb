Rails.application.routes.draw do
  resources :rooms, only: [:index, :create, :destroy] do
    resources :questions, only: [:index, :create, :destroy, :update]
  end

  resources :teachers, only: %i[show create]
  post 'auth/teacher/login', to: 'auth#teacher_login'
end
