Rails.application.routes.draw do
  resources :rooms, only: [:index, :create, :destroy] do
    resources :questions, only: [:index, :create, :destroy, :update]
  end
end
