Rails.application.routes.draw do
  namespace :admin do
    get 'post_images/new'
    get 'post_images/index'
    get 'post_images/show'
  end
  namespace :public do
    get 'post_images/new'
    get 'post_images/index'
    get 'post_images/show'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :homes, only: [:top]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :posts_tags, only: [:index, :show, :new, :create]
    resources :comments, only: [:new, :show, :create, :index]
    resources :tags, only: [:index, :new, :edit, :create, :update]
    resources :favorites, only: [:create, :destroy, :index]
    resources :post_images, only: [:new, :index, :show]
    resources :genres, only: [:index]
    resources :users, only: [:show, :edit, :update] do
      collection do
        get :confirm_deactivation
        patch :deactivation
      end
    end

    resources :posts do
      member do
        patch 'toggle_publish'
      end
    end
    post '/public/guest_sign_in', to: 'public/sessions#new_guest'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :homes, only: [:top]
    resources :posts, except: [:edit]
    resources :users, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :edit, :update, :destroy, :show]
    resources :post_tags, except: [:edit]
    resources :tags, except: [:show, :destroy]
    resources :post_images, only: [:new, :index, :show]
    resources :genres, only: [:index, :new, :create, :edit, :update]
    delete '/sign_out', to: 'sessions#destroy', as: :destroy_admin_session
  end

  root to: 'public/homes#top'
end