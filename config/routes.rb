Rails.application.routes.draw do
  resources :subjects
  resources :subjects
  resources :questions
  resources :subjects

  root 'questions#index'
end
