Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :subjects, only: [:show, :index]
  resources :questions
  resources :question_sets do
    member do
      get 'export'
    end
  end

  root 'subjects#index'
end
