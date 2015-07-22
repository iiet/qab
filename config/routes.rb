Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :questions
  resources :question_sets do
    member do
      get 'export'
    end
  end
  root 'questions#index'
end
