class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag, notice: 'タグが作成されました。'
    else
      render :new
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to @tag, notice: 'タグが更新されました。'
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
