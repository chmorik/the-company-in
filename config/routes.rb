Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'companies#index'

  resources :companies, only: [:index, :show, :create, :update]
end
