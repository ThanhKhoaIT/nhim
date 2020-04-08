Nhim::Engine.routes do
  root to: 'folders#index'

  scope as: :nhim do
    get :deleted, to: 'objects#deleted'

    resources :folders, except: [:new, :edit, :update, :destroy]
    resources :files

    resource :object, only: [] do
      get :rename
      patch :rename, action: :update_name
      delete :remove
    end
  end
end
