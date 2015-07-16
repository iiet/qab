Rails.application.routes.draw do
  resources :questions
  resources :question_sets do
    member do
      get 'export'
    end
  end
  root 'questions#index'
end
