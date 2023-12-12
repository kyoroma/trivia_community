class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @favorites = current_user.favorites.includes(:post)
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post: post)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    post = favorite.post
    favorite.destroy
    redirect_to post_path(post)
  end
end
