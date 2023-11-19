class Public::PostsController < ApplicationController
  def index
    @posts = if params[:q].present?
               Post.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
             elsif params[:tag_id].present?
               Tag.find(params[:tag_id]).posts
             else
               Post.all
             end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
