Rails.application.routes.draw do
  root to: 'welcome#home'
  resources :events
  resources :courses
  resources :cities

  root to: 'courses#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
