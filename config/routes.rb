Rails.application.routes.draw do
  resources :movies, only: %i[index show]
  resources :production_companies, only: %i[index show]
  # get 'movies/index'
  # get 'movies/show'
  # get 'production_companies/index'
  # get 'production_companies/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
