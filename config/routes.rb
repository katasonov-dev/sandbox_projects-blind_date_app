Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'

  resources :groups, only: [:index, :show] do
    collection do
      get 'build_groups'
    end
  end
end
