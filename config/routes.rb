Rails.application.routes.draw do
  get 'crawler_mailer/daily_report'
  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: "pages#home"

  get 'admin' => 'pages#admin', as: :admin
  namespace :admin do
    root to: "pages#admin"
    resources :users, only: [:index, :edit, :new, :create, :update, :destroy]
  end

  resource :crawl_config, only: [:edit, :update]

  resources :projects do 
    collection do
      get  :import_form
      post :import_csv
    end
  end

  resources :users, only: [:show]
end
