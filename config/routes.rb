Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    resources :collections do
      resources :cards
    end
    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
  end
end
