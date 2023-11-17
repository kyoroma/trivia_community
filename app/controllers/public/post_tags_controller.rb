class Public::PostTagsController < ApplicationController
  def index
    @post_tags = PostTag.all
  end

  def show
    @post_tag = PostTag.find(params[:id])
  end

  def new
    @post_tag = PostTag.new
  end

  def create
    @post_tag = PostTag.new(post_tag_params)
    if @post_tag.save
      redirect_to @post_tag, notice: '投稿タグが作成されました。'
    else
      render :new
    end
  end

  private

  def post_tag_params
    params.require(:post_tag).permit(:name)
  end
end
