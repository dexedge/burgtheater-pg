Rails.application.routes.draw do
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
  end
  
  resources :works do
    collection {post :import}
  end

  resources :performances do
    collection {post :import}
  end

  resources :authors do
    collection {post :import}
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

end
