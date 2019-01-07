Rails.application.routes.draw do
  resources :users
  root to: "events#index"
  get 'events/index'
  get 'events/import' => 'events#my_import'
  get 'works/index'
  get 'works/import' => 'works#my_import'
  get 'performances/index'
  get 'performances/import' => 'performances#my_import'
  get 'authors/index'
  get 'authors/import' => 'authors#my_import'
  get 'writings/index'
  get 'writings/import' => 'writings#my_import'
  get 'composers/index'
  get 'composers/import' => 'composers#my_import'
  get 'composings/index'
  get 'composings/import' => 'composings#my_import'
  
  resources :events do
    collection {post :import}
    member do
      get :clear
    end
  end
  
  resources :works do
    collection {post :import}
    member do
      get :authors
      post :author_add
      post :author_remove
      get :clear
    end
  end

  resources :performances do
    collection {post :import}
  end

  resources :authors do
    collection {post :import}
    member do
      get :works
    end
  end
  
  resources :writings do
    collection {post :import}
  end
  
  resources :composers do
    collection {post :import}
  end
  
  resources :composings do
    collection {post :import}
  end

  get 'users/new' => 'users#new'
  post 'users' => 'users#create'

  # log in page with form:
	get '/login' => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login' => 'sessions#create'
	
	# delete action to log out:
  delete '/logout' => 'sessions#destroy'
  
end
