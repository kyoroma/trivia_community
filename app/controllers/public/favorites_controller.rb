class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)
    if @favorite.save
      redirect_to @post, notice: 'いいねしました。'
    else
      redirect_to @post, alert: 'いいねに失敗しました。'
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @post = @favorite.post
    @favorite.destroy
    redirect_to @post, notice: 'いいねを解除しました。'
  end
end
