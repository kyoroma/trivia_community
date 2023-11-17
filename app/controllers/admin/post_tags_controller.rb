class Admin::PostTagsController < ApplicationController
  def index
    @post_tags = PostTag.all
  end

  def new
    @post_tag = PostTag.new
  end

  def create
    @post_tag = PostTag.new(post_tag_params)
    if @post_tag.save
      redirect_to admin_post_tags_path, notice: '投稿タグが作成されました。'
    else
      render :new
    end
  end

  def edit
    @post_tag = PostTag.find(params[:id])
  end

  def update
    @post_tag = PostTag.find(params[:id])
    if @post_tag.update(post_tag_params)
      redirect_to admin_post_tags_path, notice: '投稿タグが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post_tag = PostTag.find(params[:id])
    @post_tag.destroy
    redirect_to admin_post_tags_path, notice: '投稿タグが削除されました。'
  end

  private

  def post_tag_params
    params.require(:post_tag).permit(:name)
  end
end
