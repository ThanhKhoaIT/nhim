Nhim::Engine.routes do
  root to: 'folders#index'

  scope as: :nhim do
    resources :folders
    resources :files

    resource :object, only: [] do
      get :rename
      patch :rename, action: :update_name
    end
  end
end
