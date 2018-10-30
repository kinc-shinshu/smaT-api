Rails.application.routes.draw do
  get 'exams/index'
  get 'exams/show'
  get 'exams/create'
  get 'exams/edit'
  get 'exams/update'
  get 'exams/destroy'
  resources :rooms, only: [:index, :create, :destroy] do
    resources :questions, only: [:index, :create, :destroy, :update]
  end

  resources :teachers, only: %i[show create]
  post 'auth/teacher/login', to: 'auth#teacher_login'
end
