Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'roads#index'
    get 'users/mypage' =>            'users#show', as: 'mypage'
    get 'users/information/edit' =>  'users#edit', as: 'edit_information'
    patch 'users/information' =>     'users#update', as: 'update_information'
    put 'users/informateion' =>      'users#update'
    get 'users/unsubscribe' =>       'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' =>        'users#withdraw', as: 'withdraw_user'
    get 'search' => 'searches#search', as: 'search'

    resources :roads do
      resources :check_points, except: [:index] do
        resources :check_point_comments, only: [:create, :destroy]
      end
      resources :road_comments, only: [:create, :destroy]
      resource :road_favorites, only: [:create, :destroy]
    end
    get '/favorites' => 'roads#favorite', as: 'my_favorite_road'
  end
end
