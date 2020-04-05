Nhim::Engine.routes do
  root to: 'folders#index'

  scope as: :nhim do
    resources :folders
    resources :files
  end
end
