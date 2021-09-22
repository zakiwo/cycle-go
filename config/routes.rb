Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords',
  }

  # routing参照
  # https://qiita.com/ryosuketter/items/9240d8c2561b5989f049

  namespace :admin do
    resources :roads, except: [:new, :create] do
      resources :check_points, only: [:edit, :update, :destroy]
    end
    resources :users, except: [:new, :create]
  end

  scope module: :public do
    get 'about' => 'homes#about'
    root 'roads#index'
    get 'users/mypage' =>            'users#show', as: 'mypage'
    get 'users/information/edit' =>  'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    put 'users/informateion' =>      'users#update'
    get 'users/unsubscribe' =>       'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
    get 'incremental_search' => 'searches#incremental_search'
    get 'search' => 'searches#search', as: 'search'
    get 'roads/sort' => 'roads#sort', as: 'sort'

    resources :roads do
      resources :check_points, except: [:index] do
        resources :check_point_comments, only: [:create, :destroy]
      end
      resources :road_comments, only: [:create, :destroy]
      resource :road_favorites, only: [:create, :destroy]
    end
    get '/favorites' => 'roads#favorite', as: 'my_favorite_road'
    get 'roads/:id/sort_point' => 'roads#sort_point', as: 'sort_check_point'
  end
end
