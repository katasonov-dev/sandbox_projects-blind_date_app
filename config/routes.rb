Rails.application.routes.draw do
  root to: 'groups#index'
  resources :groups, only: [:index, :show] do
    collection do
      get 'build_groups'
    end
  end
end
