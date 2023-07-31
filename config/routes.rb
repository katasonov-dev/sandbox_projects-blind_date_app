Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'

  resources :groups, only: [:index, :show] do
    collection do
      get 'build_groups'
    end
  end

  resources :restaurants, only: [] do
    post 'select', on: :member
  end

  resources :users, only: [:new, :create, :index, :edit, :update]
end
