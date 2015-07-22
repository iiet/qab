Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :questions
  resources :question_sets do
    member do
      get 'export'
    end
  end
  root 'questions#index'
end
