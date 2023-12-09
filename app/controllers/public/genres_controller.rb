class Public::GenresController < ApplicationController
  def index
    @genres = Genre.all
    Rails.logger.debug "@genres: #{@genres.inspect}"  # デバッグメッセージの追加
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page]).per(10)
    @user_signed_in = user_signed_in?
  end
end
