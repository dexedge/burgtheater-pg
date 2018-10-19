Rails.application.routes.draw do
  root to: "events#index"
  get 'events/index'
  get 'events/import' => 'events#my_import'
  get 'works/index'
  get 'works/import' => 'works#my_import'
  
  resources :events do
    collection {post :import}
  end
  
  resources :works do
    collection {post :import}
  end
end
