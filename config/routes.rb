Rails.application.routes.draw do
  root "pages#home"
    
  resources :users
  
  resources :events do
    member do
      get :clear
    end
  end
  
  resources :works do
    member do
      get :authors
      post :author_add
      post :author_remove
      get :clear
    end
  end

  resources :performances 

  resources :authors do
    member do
      get :works
    end
  end
  
  resources :writings
  
  resources :composers
  
  resources :composings

  get 'users/new' => 'users#new'
  post 'users' => 'users#create'

  # log in page with form:
	get '/login' => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login' => 'sessions#create'
	
	# delete action to log out:
  delete '/logout' => 'sessions#destroy'
  
end
