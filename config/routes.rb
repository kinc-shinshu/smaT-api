Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rooms, only: [:create] do
    resources :questions, only: [:index, :create, :destroy, :update]
    get 'search', on: :collection
  end
end
