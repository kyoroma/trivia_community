Rails.application.routes.draw do
  namespace :public do
    resources :homes, only: [:top]
    resources :posts, only: [:index, :new, :show, :create]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:show, :edit, :update] do
      collection do
        get :confirm_deactivation
        patch :deactivation
      end
    end
    resources :posts_tags, only: [:index, :show, :new, :create]
    resources :comments, only: [:new, :show, :create, :index]
    resources :tags, only: [:index, :new, :edit, :create, :update]
    resources :favorites, only: [:create, :destroy]
  end

  namespace :admin do
    resources :homes, only: [:new, :create, :destroy, :top]
    resources :posts, except: [:edit]
    resources :users, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :edit, :update, :destroy]
    resources :post_tags, except: [:edit]
    resources :tags, except: [:show, :destroy]
  end

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'homes#top'
end