class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = Comment.where(admin_comment: true)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    # editアクションはset_commentで設定した@commentを利用するため、追加のコードは不要
  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'コメントが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_user_path(@comment.user), notice: 'コメントが削除されました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
