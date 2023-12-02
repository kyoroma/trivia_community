class Public::PostsController < ApplicationController
  before_action :set_genre, only: [:create]

  def index
    @posts = if params[:q].present?
               Post.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
             elsif params[:tag_id].present?
               Tag.find(params[:tag_id]).posts
             else
               Post.all
             end
  end

  def toggle_publish
    @post = Post.find(params[:id])
    @post.toggle!(:published)
    redirect_to @post, notice: '投稿の公開状態を変更しました。'
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = @genre.posts.new(post_params)

    # タグを保存する前に、カンマや改行で分割して配列に変換
    tag_list = post_params[:tag_list].split(/[,|\n]/).map(&:strip)

    # タグを設定
    @post.tag_list = tag_list

    if @post.save
      redirect_to public_genre_path(@genre), notice: '投稿が成功しました。'
    else
      render :new
    end
  end

  def search
    @results = Post.where("posted_article LIKE ?", "%#{params[:keyword]}%")
  end

  private

  def set_genre
    # params から genre_id を取得して @genre を設定する
    @genre = Genre.find(params[:post][:genre_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :posted_article, :image, :tag_list, :genre_id)
  end
end
