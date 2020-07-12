Rails.application.routes.draw do
  root "tasks#index"

  namespace :users do
    get '/sign_up', to: 'registrations#new'
    post '/sign_up', to: 'registrations#create'
    get '/log_in', to: 'sessions#new'
    post '/log_in', to: 'sessions#create'
    delete '/log_out', to: 'sessions#destroy'
  end

  namespace :admin do
    resources :users do
      member do
        post :change_authority
      end
    end
  end

  resources :tasks
end
