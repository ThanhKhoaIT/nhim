Nhim::Engine.routes do
  root to: 'folders#index'

  scope as: :nhim do
    resources :folders, only: [:index, :show, :create], param: :folder_id
    resources :files

    scope controller: :objects do
      get :deleted
      get :starred
    end

    resource :object, only: [] do
      get :rename
      patch :rename, action: :update_name
      delete :remove
      patch :restore
      post :star
      delete :remove_star
    end
  end
end
