PostitTemplate::Application.routes.draw do
	root to: 'posts#index'

	get '/register', to: 'users#new'
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get 'logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'

  	resources :posts do
  		member do
  			post 'vote'
  		end
  		resources :comments, :only => :create do
  			member do
  				post 'vote'
  			end
  		end
	end



	resources :categories, only: [:index, :show, :new, :create]
	resources :users, only:[:show, :edit, :create, :update]
end
