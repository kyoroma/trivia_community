Rails.application.routes.draw do
  namespace :admin do
    get 'post_images/new'
    get 'post_images/index'
    get 'post_images/show'
  end
  #namespace :public do
    #resources :genres, only: [:index, :show], module: :public
    #resources :posts, module: :public do
      #resource :favorite, only: [:create, :destroy]
      #resources :comments, only: [:create, :destroy]
    #end

    #resources :post_images, only: [:new, :index, :show], module: :public
    #resources :users, only: [:show, :edit, :update], module: :public

  #end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#public_guest_sign_in'
  end

  scope module: :public do
    resources :homes, only: [:top]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :posts_tags, only: [:index, :show, :new, :create]
    resources :comments, only: [:new, :show, :create, :index]
    resources :tags, only: [:index, :new, :edit, :create, :update]
    resources :favorites, only: [:create, :destroy, :index]
    resources :post_images, only: [:new, :index, :show]
    resources :genres, only: [:index, :show]
    resources :users, only: [:show, :edit, :update] do
      member do
        get :my_page
        get :confirm_deactivation
        delete :deactivation
      end
    end

    resources :posts do
      member do
        patch 'toggle_publish'
      end
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :homes, only: [:top]
    resources :posts, except: [:edit]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:index, :edit, :update, :destroy, :show]
    resources :post_tags, except: [:edit]
    resources :tags, except: [:show, :destroy]
    resources :post_images, only: [:new, :index, :show]
    resources :genres, only: [:index, :new, :create, :edit, :update, :destroy]
    delete '/sign_out', to: 'sessions#destroy', as: :destroy_admin_session
  end

  root to: 'public/homes#top'
end